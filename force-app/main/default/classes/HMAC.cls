global class HMAC {

    public static void generateSignature() {
        String salt = String.valueOf(Crypto.getRandomInteger());
        String secretKey = 'xjoavU2LaJ1vaGCx4Ekd';
        String signature = generateHmacSHA256Signature(salt, secretKey);
        System.debug('Signature : ' + signature);
    }

    private static String generateHmacSHA256Signature(String saltValue, String secretKeyValue) {
        String algorithmName = 'HmacSHA256';
        Blob hmacData = Crypto.generateMac(algorithmName, Blob.valueOf(saltValue), Blob.valueOf(secretKeyValue));
        return EncodingUtil.base64Encode(hmacData);
    }
}