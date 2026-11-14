
vector_wider_than_the_registers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<ops_s8x32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpaddb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsubb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rdi)
               	leaq	0x40(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	vpextrb	$0x0, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x0, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x20(%rbp)
               	vpextrb	$0x1, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x1, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x1f(%rbp)
               	vpextrb	$0x2, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x2, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x1e(%rbp)
               	vpextrb	$0x3, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x3, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x1d(%rbp)
               	vpextrb	$0x4, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x4, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x1c(%rbp)
               	vpextrb	$0x5, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x5, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x1b(%rbp)
               	vpextrb	$0x6, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x6, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x1a(%rbp)
               	vpextrb	$0x7, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x7, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x19(%rbp)
               	vpextrb	$0x8, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x8, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x18(%rbp)
               	vpextrb	$0x9, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x9, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x17(%rbp)
               	vpextrb	$0xa, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xa, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x16(%rbp)
               	vpextrb	$0xb, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xb, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x15(%rbp)
               	vpextrb	$0xc, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xc, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x14(%rbp)
               	vpextrb	$0xd, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xd, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x13(%rbp)
               	vpextrb	$0xe, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xe, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x12(%rbp)
               	vpextrb	$0xf, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xf, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x11(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x0, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x0, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x1, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x1, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0xf(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x2, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x2, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0xe(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x3, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x3, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0xd(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x4, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x4, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0xc(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x5, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x5, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0xb(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x6, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x6, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0xa(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x7, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x7, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x9(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x8, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x8, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x8(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x9, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x9, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x7(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xa, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xa, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x6(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xb, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xb, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x5(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xc, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xc, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x4(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xd, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xd, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x3(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xe, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xe, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x2(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xf, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xf, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x1(%rbp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpand	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rdi)
               	vpor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rdi)
               	vpxor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xa0(%rdi)
               	xorl	%eax, %eax
               	vmovq	%rax, %xmm14
               	vpsubb	%ymm0, %ymm14, %ymm2
               	vmovups	%ymm2, 0xc0(%rdi)
               	vpcmpeqd	%ymm2, %ymm2, %ymm2
               	vpxor	%ymm2, %ymm0, %ymm2
               	vmovups	%ymm2, 0xe0(%rdi)
               	leaq	0x100(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	vpextrb	$0x0, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x20(%rbp)
               	vpextrb	$0x1, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x1f(%rbp)
               	vpextrb	$0x2, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x1e(%rbp)
               	vpextrb	$0x3, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x1d(%rbp)
               	vpextrb	$0x4, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x1c(%rbp)
               	vpextrb	$0x5, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x1b(%rbp)
               	vpextrb	$0x6, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x1a(%rbp)
               	vpextrb	$0x7, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x19(%rbp)
               	vpextrb	$0x8, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x18(%rbp)
               	vpextrb	$0x9, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x17(%rbp)
               	vpextrb	$0xa, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x16(%rbp)
               	vpextrb	$0xb, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x15(%rbp)
               	vpextrb	$0xc, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x14(%rbp)
               	vpextrb	$0xd, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x13(%rbp)
               	vpextrb	$0xe, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x12(%rbp)
               	vpextrb	$0xf, %xmm0, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x11(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x0, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x10(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x1, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0xf(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x2, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0xe(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x3, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0xd(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x4, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0xc(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x5, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0xb(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x6, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0xa(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x7, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x9(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x8, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x8(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x9, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x7(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xa, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x6(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xb, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x5(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xc, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x4(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xd, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x3(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xe, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x2(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xf, %xmm2, %edx
               	movsbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, -0x1(%rbp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x120(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	vpextrb	$0x0, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x20(%rbp)
               	vpextrb	$0x1, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x1f(%rbp)
               	vpextrb	$0x2, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x1e(%rbp)
               	vpextrb	$0x3, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x1d(%rbp)
               	vpextrb	$0x4, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x1c(%rbp)
               	vpextrb	$0x5, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x1b(%rbp)
               	vpextrb	$0x6, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x1a(%rbp)
               	vpextrb	$0x7, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x19(%rbp)
               	vpextrb	$0x8, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x18(%rbp)
               	vpextrb	$0x9, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x17(%rbp)
               	vpextrb	$0xa, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x16(%rbp)
               	vpextrb	$0xb, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x15(%rbp)
               	vpextrb	$0xc, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x14(%rbp)
               	vpextrb	$0xd, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x13(%rbp)
               	vpextrb	$0xe, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x12(%rbp)
               	vpextrb	$0xf, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x11(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x0, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x10(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x1, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0xf(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x2, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0xe(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x3, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0xd(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x4, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0xc(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x5, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0xb(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x6, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0xa(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x7, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x9(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x8, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x8(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x9, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x7(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xa, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x6(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xb, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x5(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xc, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x4(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xd, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x3(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xe, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x2(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xf, %xmm2, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x5, %rdx
               	movb	%dl, -0x1(%rbp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpcmpgtb	%ymm0, %ymm1, %ymm2
               	vmovups	%ymm2, 0x140(%rdi)
               	leaq	0x160(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	vpextrb	$0x0, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x0, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x20(%rbp)
               	vpextrb	$0x1, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x1, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x1f(%rbp)
               	vpextrb	$0x2, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x2, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x1e(%rbp)
               	vpextrb	$0x3, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x3, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x1d(%rbp)
               	vpextrb	$0x4, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x4, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x1c(%rbp)
               	vpextrb	$0x5, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x5, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x1b(%rbp)
               	vpextrb	$0x6, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x6, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x1a(%rbp)
               	vpextrb	$0x7, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x7, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x19(%rbp)
               	vpextrb	$0x8, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x8, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x18(%rbp)
               	vpextrb	$0x9, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x9, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x17(%rbp)
               	vpextrb	$0xa, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xa, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x16(%rbp)
               	vpextrb	$0xb, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xb, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x15(%rbp)
               	vpextrb	$0xc, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xc, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x14(%rbp)
               	vpextrb	$0xd, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xd, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x13(%rbp)
               	vpextrb	$0xe, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xe, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x12(%rbp)
               	vpextrb	$0xf, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xf, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x11(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x0, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x0, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x10(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x1, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x1, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0xf(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x2, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x2, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0xe(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x3, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x3, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0xd(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x4, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x4, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0xc(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x5, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x5, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0xb(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x6, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x6, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0xa(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x7, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x7, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x9(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x8, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x8, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x8(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x9, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x9, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x7(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xa, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xa, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x6(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xb, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xb, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x5(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xc, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xc, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xd, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xd, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xe, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xe, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x2(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xf, %xmm2, %edx
               	movsbq	%dl, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xf, %xmm2, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x1(%rbp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpcmpeqb	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x180(%rdi)
               	vzeroupper
               	leave
               	retq

<check_s8x32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x1e0, %rsp            # imm = 0x1E0
               	andq	$-0x20, %rsp
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movb	%cl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movb	%dil, (%rsp,%rax)
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	shrq	$0x20, %r8
               	leaq	(%r8,%r8,2), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movsbq	%cl, %rcx
               	jmp	<addr>
               	movsbq	(%rsp,%rax), %rcx
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	(%rsp,%rax), %rcx
               	movsbq	0x20(%rsp,%rax), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	%sil, %rsi
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movsbq	%dil, %rdi
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	movsbq	%r8b, %r8
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	movsbq	%r9b, %r9
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	xorl	%edx, %edx
               	movq	%rcx, %r13
               	negq	%r13
               	movsbq	%r13b, %r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	shlq	$0x3, %rcx
               	movsbq	%cl, %rcx
               	movsbq	(%rsp,%rax), %r15
               	sarq	$0x5, %r15
               	movsbq	(%rsp,%rax), %r10
               	movq	%r10, -0x8(%rbp)
               	movsbq	0x20(%rsp,%rax), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	-0x8(%rbp), %r10
               	cmpl	-0x10(%rbp), %r10d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	negq	%r10
               	movq	%r10, -0x8(%rbp)
               	movsbq	(%rsp,%rax), %r10
               	movq	%r10, -0x10(%rbp)
               	movsbq	0x20(%rsp,%rax), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x10(%rbp), %r10
               	cmpl	-0x18(%rbp), %r10d
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	negq	%r10
               	movq	%r10, -0x10(%rbp)
               	movsbq	(%rsp,%rax), %r10
               	movq	%r10, -0x18(%rbp)
               	movsbq	0x20(%rsp,%rax), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x18(%rbp), %r10
               	cmpl	-0x20(%rbp), %r10d
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	negq	%r10
               	movq	%r10, -0x18(%rbp)
               	movsbq	0x40(%rsp,%rax), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpl	%r10d, %esi
               	jne	<addr>
               	movl	$0x1, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x20, %rsi
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x40, %rsi
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	$0x3, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x60, %rsi
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	$0x4, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x80, %rsi
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	%ebx, %esi
               	jne	<addr>
               	movl	$0x5, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xa0, %rsi
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	%r12d, %esi
               	jne	<addr>
               	movl	$0x6, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xc0, %rsi
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	%r13d, %esi
               	jne	<addr>
               	movl	$0x7, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xe0, %rsi
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	%r14d, %esi
               	jne	<addr>
               	movl	$0x8, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x100, %rsi            # imm = 0x100
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movl	$0x9, %edx
               	leaq	0x40(%rsp), %rcx
               	leaq	0x120(%rcx), %rsi
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	%r15d, %esi
               	jne	<addr>
               	movl	$0xa, %edx
               	addq	$0x140, %rcx            # imm = 0x140
               	movsbq	(%rcx,%rax), %rcx
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %edx
               	leaq	0x40(%rsp), %rcx
               	leaq	0x160(%rcx), %rsi
               	movsbq	(%rsi,%rax), %rsi
               	cmpl	-0x10(%rbp), %esi
               	jne	<addr>
               	movl	$0xc, %edx
               	addq	$0x180, %rcx            # imm = 0x180
               	movsbq	(%rcx,%rax), %rcx
               	cmpl	-0x18(%rbp), %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x10(%rdx), %rax
               	incq	%rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<ops_u8x64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rsi), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x40(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpaddb	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpaddb	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, (%rdi)
               	vmovups	%ymm1, 0x20(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpsubb	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpsubb	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x40(%rdi)
               	vmovups	%ymm1, 0x60(%rdi)
               	leaq	0x80(%rdi), %rax
               	leaq	0x80(%rsp), %rcx
               	movzbq	(%rsp), %rdx
               	movzbq	0x40(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x80(%rsp)
               	movzbq	0x1(%rsp), %rdx
               	movzbq	0x41(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x81(%rsp)
               	movzbq	0x2(%rsp), %rdx
               	movzbq	0x42(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x82(%rsp)
               	movzbq	0x3(%rsp), %rdx
               	movzbq	0x43(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x83(%rsp)
               	movzbq	0x4(%rsp), %rdx
               	movzbq	0x44(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x84(%rsp)
               	movzbq	0x5(%rsp), %rdx
               	movzbq	0x45(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x85(%rsp)
               	movzbq	0x6(%rsp), %rdx
               	movzbq	0x46(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x86(%rsp)
               	movzbq	0x7(%rsp), %rdx
               	movzbq	0x47(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x87(%rsp)
               	movzbq	0x8(%rsp), %rdx
               	movzbq	0x48(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x88(%rsp)
               	movzbq	0x9(%rsp), %rdx
               	movzbq	0x49(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x89(%rsp)
               	movzbq	0xa(%rsp), %rdx
               	movzbq	0x4a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x8a(%rsp)
               	movzbq	0xb(%rsp), %rdx
               	movzbq	0x4b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x8b(%rsp)
               	movzbq	0xc(%rsp), %rdx
               	movzbq	0x4c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x8c(%rsp)
               	movzbq	0xd(%rsp), %rdx
               	movzbq	0x4d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x8d(%rsp)
               	movzbq	0xe(%rsp), %rdx
               	movzbq	0x4e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x8e(%rsp)
               	movzbq	0xf(%rsp), %rdx
               	movzbq	0x4f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x8f(%rsp)
               	movzbq	0x10(%rsp), %rdx
               	movzbq	0x50(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x90(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x51(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x91(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x52(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x92(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x53(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x93(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x54(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x94(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x55(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x95(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x56(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x96(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x57(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x97(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x58(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x98(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x59(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x99(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x5a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x9a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x5b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x9b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x5c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x9c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x5d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x9d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x5e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x9e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x5f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x9f(%rsp)
               	movzbq	0x20(%rsp), %rdx
               	movzbq	0x60(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa0(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	movzbq	0x61(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa1(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	movzbq	0x62(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa2(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	movzbq	0x63(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa3(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	movzbq	0x64(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa4(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	movzbq	0x65(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa5(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	movzbq	0x66(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa6(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	movzbq	0x67(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa7(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	movzbq	0x68(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa8(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	movzbq	0x69(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xa9(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	movzbq	0x6a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xaa(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	movzbq	0x6b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xab(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	movzbq	0x6c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xac(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	movzbq	0x6d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xad(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	movzbq	0x6e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xae(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	movzbq	0x6f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xaf(%rsp)
               	movzbq	0x30(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb0(%rsp)
               	movzbq	0x31(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb1(%rsp)
               	movzbq	0x32(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb2(%rsp)
               	movzbq	0x33(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb3(%rsp)
               	movzbq	0x34(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb4(%rsp)
               	movzbq	0x35(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb5(%rsp)
               	movzbq	0x36(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb6(%rsp)
               	movzbq	0x37(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb7(%rsp)
               	movzbq	0x38(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb8(%rsp)
               	movzbq	0x39(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xb9(%rsp)
               	movzbq	0x3a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xba(%rsp)
               	movzbq	0x3b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xbb(%rsp)
               	movzbq	0x3c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xbc(%rsp)
               	movzbq	0x3d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xbd(%rsp)
               	movzbq	0x3e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xbe(%rsp)
               	movzbq	0x3f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0xbf(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpand	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpand	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0xc0(%rdi)
               	vmovups	%ymm1, 0xe0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpor	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpor	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x100(%rdi)
               	vmovups	%ymm1, 0x120(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpxor	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpxor	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x140(%rdi)
               	vmovups	%ymm1, 0x160(%rdi)
               	xorl	%eax, %eax
               	vmovups	(%rsp), %ymm0
               	vmovq	%rax, %xmm14
               	vpsubb	%ymm0, %ymm14, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovq	%rax, %xmm14
               	vpsubb	%ymm1, %ymm14, %ymm1
               	vmovups	%ymm0, 0x180(%rdi)
               	vmovups	%ymm1, 0x1a0(%rdi)
               	vpcmpeqd	%ymm0, %ymm0, %ymm0
               	vmovups	(%rsp), %ymm1
               	vpxor	%ymm0, %ymm1, %ymm1
               	vmovups	0x20(%rsp), %ymm2
               	vpxor	%ymm0, %ymm2, %ymm0
               	vmovups	%ymm1, 0x1c0(%rdi)
               	vmovups	%ymm0, 0x1e0(%rdi)
               	leaq	0x200(%rdi), %rax
               	leaq	0x80(%rsp), %rcx
               	movzbq	(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x80(%rsp)
               	movzbq	0x1(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x81(%rsp)
               	movzbq	0x2(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x82(%rsp)
               	movzbq	0x3(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x83(%rsp)
               	movzbq	0x4(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x84(%rsp)
               	movzbq	0x5(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x85(%rsp)
               	movzbq	0x6(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x86(%rsp)
               	movzbq	0x7(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x87(%rsp)
               	movzbq	0x8(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x88(%rsp)
               	movzbq	0x9(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x89(%rsp)
               	movzbq	0xa(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x8a(%rsp)
               	movzbq	0xb(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x8b(%rsp)
               	movzbq	0xc(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x8c(%rsp)
               	movzbq	0xd(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x8d(%rsp)
               	movzbq	0xe(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x8e(%rsp)
               	movzbq	0xf(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x8f(%rsp)
               	movzbq	0x10(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x90(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x91(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x92(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x93(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x94(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x95(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x96(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x97(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x98(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x99(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x9a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x9b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x9c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x9d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x9e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x9f(%rsp)
               	movzbq	0x20(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa0(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa1(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa2(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa3(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa4(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa5(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa6(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa7(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa8(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xa9(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xaa(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xab(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xac(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xad(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xae(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xaf(%rsp)
               	movzbq	0x30(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb0(%rsp)
               	movzbq	0x31(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb1(%rsp)
               	movzbq	0x32(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb2(%rsp)
               	movzbq	0x33(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb3(%rsp)
               	movzbq	0x34(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb4(%rsp)
               	movzbq	0x35(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb5(%rsp)
               	movzbq	0x36(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb6(%rsp)
               	movzbq	0x37(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb7(%rsp)
               	movzbq	0x38(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb8(%rsp)
               	movzbq	0x39(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xb9(%rsp)
               	movzbq	0x3a(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xba(%rsp)
               	movzbq	0x3b(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xbb(%rsp)
               	movzbq	0x3c(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xbc(%rsp)
               	movzbq	0x3d(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xbd(%rsp)
               	movzbq	0x3e(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xbe(%rsp)
               	movzbq	0x3f(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0xbf(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x240(%rdi), %rax
               	leaq	0x80(%rsp), %rcx
               	movzbq	(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x80(%rsp)
               	movzbq	0x1(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x81(%rsp)
               	movzbq	0x2(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x82(%rsp)
               	movzbq	0x3(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x83(%rsp)
               	movzbq	0x4(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x84(%rsp)
               	movzbq	0x5(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x85(%rsp)
               	movzbq	0x6(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x86(%rsp)
               	movzbq	0x7(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x87(%rsp)
               	movzbq	0x8(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x88(%rsp)
               	movzbq	0x9(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x89(%rsp)
               	movzbq	0xa(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x8a(%rsp)
               	movzbq	0xb(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x8b(%rsp)
               	movzbq	0xc(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x8c(%rsp)
               	movzbq	0xd(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x8d(%rsp)
               	movzbq	0xe(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x8e(%rsp)
               	movzbq	0xf(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x8f(%rsp)
               	movzbq	0x10(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x90(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x91(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x92(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x93(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x94(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x95(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x96(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x97(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x98(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x99(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x9a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x9b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x9c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x9d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x9e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0x9f(%rsp)
               	movzbq	0x20(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa0(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa1(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa2(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa3(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa4(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa5(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa6(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa7(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa8(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xa9(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xaa(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xab(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xac(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xad(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xae(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xaf(%rsp)
               	movzbq	0x30(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb0(%rsp)
               	movzbq	0x31(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb1(%rsp)
               	movzbq	0x32(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb2(%rsp)
               	movzbq	0x33(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb3(%rsp)
               	movzbq	0x34(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb4(%rsp)
               	movzbq	0x35(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb5(%rsp)
               	movzbq	0x36(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb6(%rsp)
               	movzbq	0x37(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb7(%rsp)
               	movzbq	0x38(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb8(%rsp)
               	movzbq	0x39(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xb9(%rsp)
               	movzbq	0x3a(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xba(%rsp)
               	movzbq	0x3b(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xbb(%rsp)
               	movzbq	0x3c(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xbc(%rsp)
               	movzbq	0x3d(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xbd(%rsp)
               	movzbq	0x3e(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xbe(%rsp)
               	movzbq	0x3f(%rsp), %rdx
               	shrq	$0x5, %rdx
               	movb	%dl, 0xbf(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x280(%rdi), %rax
               	leaq	0x80(%rsp), %rcx
               	movzbq	(%rsp), %rdx
               	movzbq	0x40(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x80(%rsp)
               	movzbq	0x1(%rsp), %rdx
               	movzbq	0x41(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x81(%rsp)
               	movzbq	0x2(%rsp), %rdx
               	movzbq	0x42(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x82(%rsp)
               	movzbq	0x3(%rsp), %rdx
               	movzbq	0x43(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x83(%rsp)
               	movzbq	0x4(%rsp), %rdx
               	movzbq	0x44(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x84(%rsp)
               	movzbq	0x5(%rsp), %rdx
               	movzbq	0x45(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x85(%rsp)
               	movzbq	0x6(%rsp), %rdx
               	movzbq	0x46(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x86(%rsp)
               	movzbq	0x7(%rsp), %rdx
               	movzbq	0x47(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x87(%rsp)
               	movzbq	0x8(%rsp), %rdx
               	movzbq	0x48(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x88(%rsp)
               	movzbq	0x9(%rsp), %rdx
               	movzbq	0x49(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x89(%rsp)
               	movzbq	0xa(%rsp), %rdx
               	movzbq	0x4a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8a(%rsp)
               	movzbq	0xb(%rsp), %rdx
               	movzbq	0x4b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8b(%rsp)
               	movzbq	0xc(%rsp), %rdx
               	movzbq	0x4c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8c(%rsp)
               	movzbq	0xd(%rsp), %rdx
               	movzbq	0x4d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8d(%rsp)
               	movzbq	0xe(%rsp), %rdx
               	movzbq	0x4e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8e(%rsp)
               	movzbq	0xf(%rsp), %rdx
               	movzbq	0x4f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8f(%rsp)
               	movzbq	0x10(%rsp), %rdx
               	movzbq	0x50(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x90(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x51(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x91(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x52(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x92(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x53(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x93(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x54(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x94(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x55(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x95(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x56(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x96(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x57(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x97(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x58(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x98(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x59(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x99(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x5a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x5b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x5c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x5d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x5e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x5f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9f(%rsp)
               	movzbq	0x20(%rsp), %rdx
               	movzbq	0x60(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa0(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	movzbq	0x61(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa1(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	movzbq	0x62(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa2(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	movzbq	0x63(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa3(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	movzbq	0x64(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa4(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	movzbq	0x65(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa5(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	movzbq	0x66(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa6(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	movzbq	0x67(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa7(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	movzbq	0x68(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa8(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	movzbq	0x69(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa9(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	movzbq	0x6a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xaa(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	movzbq	0x6b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xab(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	movzbq	0x6c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xac(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	movzbq	0x6d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xad(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	movzbq	0x6e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xae(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	movzbq	0x6f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xaf(%rsp)
               	movzbq	0x30(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb0(%rsp)
               	movzbq	0x31(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb1(%rsp)
               	movzbq	0x32(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb2(%rsp)
               	movzbq	0x33(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb3(%rsp)
               	movzbq	0x34(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb4(%rsp)
               	movzbq	0x35(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb5(%rsp)
               	movzbq	0x36(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb6(%rsp)
               	movzbq	0x37(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb7(%rsp)
               	movzbq	0x38(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb8(%rsp)
               	movzbq	0x39(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb9(%rsp)
               	movzbq	0x3a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xba(%rsp)
               	movzbq	0x3b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbb(%rsp)
               	movzbq	0x3c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbc(%rsp)
               	movzbq	0x3d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbd(%rsp)
               	movzbq	0x3e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbe(%rsp)
               	movzbq	0x3f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbf(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x2c0(%rdi), %rax
               	leaq	0x80(%rsp), %rcx
               	movzbq	(%rsp), %rdx
               	movzbq	0x40(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x80(%rsp)
               	movzbq	0x1(%rsp), %rdx
               	movzbq	0x41(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x81(%rsp)
               	movzbq	0x2(%rsp), %rdx
               	movzbq	0x42(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x82(%rsp)
               	movzbq	0x3(%rsp), %rdx
               	movzbq	0x43(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x83(%rsp)
               	movzbq	0x4(%rsp), %rdx
               	movzbq	0x44(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x84(%rsp)
               	movzbq	0x5(%rsp), %rdx
               	movzbq	0x45(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x85(%rsp)
               	movzbq	0x6(%rsp), %rdx
               	movzbq	0x46(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x86(%rsp)
               	movzbq	0x7(%rsp), %rdx
               	movzbq	0x47(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x87(%rsp)
               	movzbq	0x8(%rsp), %rdx
               	movzbq	0x48(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x88(%rsp)
               	movzbq	0x9(%rsp), %rdx
               	movzbq	0x49(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x89(%rsp)
               	movzbq	0xa(%rsp), %rdx
               	movzbq	0x4a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8a(%rsp)
               	movzbq	0xb(%rsp), %rdx
               	movzbq	0x4b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8b(%rsp)
               	movzbq	0xc(%rsp), %rdx
               	movzbq	0x4c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8c(%rsp)
               	movzbq	0xd(%rsp), %rdx
               	movzbq	0x4d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8d(%rsp)
               	movzbq	0xe(%rsp), %rdx
               	movzbq	0x4e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8e(%rsp)
               	movzbq	0xf(%rsp), %rdx
               	movzbq	0x4f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8f(%rsp)
               	movzbq	0x10(%rsp), %rdx
               	movzbq	0x50(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x90(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x51(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x91(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x52(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x92(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x53(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x93(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x54(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x94(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x55(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x95(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x56(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x96(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x57(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x97(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x58(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x98(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x59(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x99(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x5a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x5b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x5c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x5d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x5e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x5f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9f(%rsp)
               	movzbq	0x20(%rsp), %rdx
               	movzbq	0x60(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa0(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	movzbq	0x61(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa1(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	movzbq	0x62(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa2(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	movzbq	0x63(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa3(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	movzbq	0x64(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa4(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	movzbq	0x65(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa5(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	movzbq	0x66(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa6(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	movzbq	0x67(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa7(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	movzbq	0x68(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa8(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	movzbq	0x69(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa9(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	movzbq	0x6a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xaa(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	movzbq	0x6b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xab(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	movzbq	0x6c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xac(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	movzbq	0x6d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xad(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	movzbq	0x6e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xae(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	movzbq	0x6f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xaf(%rsp)
               	movzbq	0x30(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb0(%rsp)
               	movzbq	0x31(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb1(%rsp)
               	movzbq	0x32(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb2(%rsp)
               	movzbq	0x33(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb3(%rsp)
               	movzbq	0x34(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb4(%rsp)
               	movzbq	0x35(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb5(%rsp)
               	movzbq	0x36(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb6(%rsp)
               	movzbq	0x37(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb7(%rsp)
               	movzbq	0x38(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb8(%rsp)
               	movzbq	0x39(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb9(%rsp)
               	movzbq	0x3a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xba(%rsp)
               	movzbq	0x3b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbb(%rsp)
               	movzbq	0x3c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbc(%rsp)
               	movzbq	0x3d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbd(%rsp)
               	movzbq	0x3e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbe(%rsp)
               	movzbq	0x3f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xbf(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpcmpeqb	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpcmpeqb	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x300(%rdi)
               	vmovups	%ymm1, 0x320(%rdi)
               	vzeroupper
               	leave
               	retq

<check_u8x64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x3c0, %rsp            # imm = 0x3C0
               	andq	$-0x40, %rsp
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movb	%cl, 0x40(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsp,%rax)
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	shrq	$0x20, %r8
               	leaq	(%r8,%r8,2), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movzbq	(%rsp,%rax), %rcx
               	jmp	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rcx
               	movzbq	0x40(%rsp,%rax), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	andq	$0xff, %rsi
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	andq	$0xff, %rdi
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	andq	$0xff, %r8
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	xorl	%edx, %edx
               	movq	%rcx, %r13
               	negq	%r13
               	andq	$0xff, %r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	andq	$0xff, %r14
               	shlq	$0x3, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%rsp,%rax), %r15
               	shrq	$0x5, %r15
               	movzbq	(%rsp,%rax), %r10
               	movq	%r10, -0x8(%rbp)
               	movzbq	0x40(%rsp,%rax), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	-0x8(%rbp), %r10
               	cmpl	-0x10(%rbp), %r10d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	negq	%r10
               	movq	%r10, -0x8(%rbp)
               	andq	$0xff, %r10
               	movq	%r10, -0x8(%rbp)
               	movzbq	(%rsp,%rax), %r10
               	movq	%r10, -0x10(%rbp)
               	movzbq	0x40(%rsp,%rax), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x10(%rbp), %r10
               	cmpl	-0x18(%rbp), %r10d
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	negq	%r10
               	movq	%r10, -0x10(%rbp)
               	andq	$0xff, %r10
               	movq	%r10, -0x10(%rbp)
               	movzbq	(%rsp,%rax), %r10
               	movq	%r10, -0x18(%rbp)
               	movzbq	0x40(%rsp,%rax), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x18(%rbp), %r10
               	cmpl	-0x20(%rbp), %r10d
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	negq	%r10
               	movq	%r10, -0x18(%rbp)
               	andq	$0xff, %r10
               	movq	%r10, -0x18(%rbp)
               	movzbq	0x80(%rsp,%rax), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpl	%r10d, %esi
               	jne	<addr>
               	movl	$0x1, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x40, %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x80, %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	$0x3, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0xc0, %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	$0x4, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x100, %rsi            # imm = 0x100
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%ebx, %esi
               	jne	<addr>
               	movl	$0x5, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x140, %rsi            # imm = 0x140
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%r12d, %esi
               	jne	<addr>
               	movl	$0x6, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x180, %rsi            # imm = 0x180
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%r13d, %esi
               	jne	<addr>
               	movl	$0x7, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x1c0, %rsi            # imm = 0x1C0
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%r14d, %esi
               	jne	<addr>
               	movl	$0x8, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x200, %rsi            # imm = 0x200
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movl	$0x9, %edx
               	leaq	0x80(%rsp), %rcx
               	leaq	0x240(%rcx), %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%r15d, %esi
               	jne	<addr>
               	movl	$0xa, %edx
               	addq	$0x280, %rcx            # imm = 0x280
               	movzbq	(%rcx,%rax), %rcx
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %edx
               	leaq	0x80(%rsp), %rcx
               	leaq	0x2c0(%rcx), %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	-0x10(%rbp), %esi
               	jne	<addr>
               	movl	$0xc, %edx
               	addq	$0x300, %rcx            # imm = 0x300
               	movzbq	(%rcx,%rax), %rcx
               	cmpl	-0x18(%rbp), %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x20(%rdx), %rax
               	incq	%rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<ops_u16x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpaddw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsubw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rdi)
               	vpmullw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rdi)
               	vpand	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rdi)
               	vpor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rdi)
               	vpxor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xa0(%rdi)
               	xorl	%eax, %eax
               	vmovq	%rax, %xmm14
               	vpsubw	%ymm0, %ymm14, %ymm2
               	vmovups	%ymm2, 0xc0(%rdi)
               	vpcmpeqd	%ymm2, %ymm2, %ymm2
               	vpxor	%ymm2, %ymm0, %ymm2
               	vmovups	%ymm2, 0xe0(%rdi)
               	vpsllw	$0x3, %ymm0, %ymm2
               	vmovups	%ymm2, 0x100(%rdi)
               	vpsrlw	$0x5, %ymm0, %ymm2
               	vmovups	%ymm2, 0x120(%rdi)
               	leaq	0x140(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	vpextrw	$0x0, %xmm0, %edx
               	vpextrw	$0x0, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x20(%rbp)
               	vpextrw	$0x1, %xmm0, %edx
               	vpextrw	$0x1, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x1e(%rbp)
               	vpextrw	$0x2, %xmm0, %edx
               	vpextrw	$0x2, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x1c(%rbp)
               	vpextrw	$0x3, %xmm0, %edx
               	vpextrw	$0x3, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x1a(%rbp)
               	vpextrw	$0x4, %xmm0, %edx
               	vpextrw	$0x4, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x18(%rbp)
               	vpextrw	$0x5, %xmm0, %edx
               	vpextrw	$0x5, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x16(%rbp)
               	vpextrw	$0x6, %xmm0, %edx
               	vpextrw	$0x6, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x14(%rbp)
               	vpextrw	$0x7, %xmm0, %edx
               	vpextrw	$0x7, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x12(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x0, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x0, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x10(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x1, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x1, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0xe(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x2, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x2, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0xc(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x3, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x3, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0xa(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x4, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x4, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x8(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x5, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x5, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x6(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x6, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x6, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x7, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x7, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x2(%rbp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x160(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	vpextrw	$0x0, %xmm0, %edx
               	vpextrw	$0x0, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x20(%rbp)
               	vpextrw	$0x1, %xmm0, %edx
               	vpextrw	$0x1, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x1e(%rbp)
               	vpextrw	$0x2, %xmm0, %edx
               	vpextrw	$0x2, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x1c(%rbp)
               	vpextrw	$0x3, %xmm0, %edx
               	vpextrw	$0x3, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x1a(%rbp)
               	vpextrw	$0x4, %xmm0, %edx
               	vpextrw	$0x4, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x18(%rbp)
               	vpextrw	$0x5, %xmm0, %edx
               	vpextrw	$0x5, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x16(%rbp)
               	vpextrw	$0x6, %xmm0, %edx
               	vpextrw	$0x6, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x14(%rbp)
               	vpextrw	$0x7, %xmm0, %edx
               	vpextrw	$0x7, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x12(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x0, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x0, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x10(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x1, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x1, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0xe(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x2, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x2, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0xc(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x3, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x3, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0xa(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x4, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x4, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x8(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x5, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x5, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x6(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x6, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x6, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x7, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x7, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x2(%rbp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpcmpeqw	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x180(%rdi)
               	vzeroupper
               	leave
               	retq

<check_u16x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x1e0, %rsp            # imm = 0x1E0
               	andq	$-0x20, %rsp
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movw	%cx, 0x20(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, (%rsp,%rax,2)
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	shrq	$0x20, %r8
               	leaq	(%r8,%r8,2), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	jmp	<addr>
               	movzwq	(%rsp,%rax,2), %rcx
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movzwq	(%rsp,%rax,2), %rcx
               	movzwq	0x20(%rsp,%rax,2), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	xorl	%edx, %edx
               	movq	%rcx, %r13
               	negq	%r13
               	andq	$0xffff, %r13           # imm = 0xFFFF
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	shlq	$0x3, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movzwq	(%rsp,%rax,2), %r15
               	shrq	$0x5, %r15
               	movzwq	(%rsp,%rax,2), %r10
               	movq	%r10, -0x8(%rbp)
               	movzwq	0x20(%rsp,%rax,2), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	-0x8(%rbp), %r10
               	cmpl	-0x10(%rbp), %r10d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	negq	%r10
               	movq	%r10, -0x8(%rbp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, -0x8(%rbp)
               	movzwq	(%rsp,%rax,2), %r10
               	movq	%r10, -0x10(%rbp)
               	movzwq	0x20(%rsp,%rax,2), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x10(%rbp), %r10
               	cmpl	-0x18(%rbp), %r10d
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	negq	%r10
               	movq	%r10, -0x10(%rbp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, -0x10(%rbp)
               	movzwq	(%rsp,%rax,2), %r10
               	movq	%r10, -0x18(%rbp)
               	movzwq	0x20(%rsp,%rax,2), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x18(%rbp), %r10
               	cmpl	-0x20(%rbp), %r10d
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	negq	%r10
               	movq	%r10, -0x18(%rbp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, -0x18(%rbp)
               	movzwq	0x40(%rsp,%rax,2), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpl	%r10d, %esi
               	jne	<addr>
               	movl	$0x1, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x20, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x40, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	$0x3, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x60, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	$0x4, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x80, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%ebx, %esi
               	jne	<addr>
               	movl	$0x5, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xa0, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%r12d, %esi
               	jne	<addr>
               	movl	$0x6, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xc0, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%r13d, %esi
               	jne	<addr>
               	movl	$0x7, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xe0, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%r14d, %esi
               	jne	<addr>
               	movl	$0x8, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x100, %rsi            # imm = 0x100
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movl	$0x9, %edx
               	leaq	0x40(%rsp), %rcx
               	leaq	0x120(%rcx), %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%r15d, %esi
               	jne	<addr>
               	movl	$0xa, %edx
               	addq	$0x140, %rcx            # imm = 0x140
               	movzwq	(%rcx,%rax,2), %rcx
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %edx
               	leaq	0x40(%rsp), %rcx
               	leaq	0x160(%rcx), %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	-0x10(%rbp), %esi
               	jne	<addr>
               	movl	$0xc, %edx
               	addq	$0x180, %rcx            # imm = 0x180
               	movzwq	(%rcx,%rax,2), %rcx
               	cmpl	-0x18(%rbp), %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x30(%rdx), %rax
               	incq	%rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<ops_s16x32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rsi), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x40(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpaddw	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpaddw	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, (%rdi)
               	vmovups	%ymm1, 0x20(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpsubw	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpsubw	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x40(%rdi)
               	vmovups	%ymm1, 0x60(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpmullw	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpmullw	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x80(%rdi)
               	vmovups	%ymm1, 0xa0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpand	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpand	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0xc0(%rdi)
               	vmovups	%ymm1, 0xe0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpor	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpor	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x100(%rdi)
               	vmovups	%ymm1, 0x120(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpxor	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpxor	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x140(%rdi)
               	vmovups	%ymm1, 0x160(%rdi)
               	xorl	%eax, %eax
               	vmovups	(%rsp), %ymm0
               	vmovq	%rax, %xmm14
               	vpsubw	%ymm0, %ymm14, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovq	%rax, %xmm14
               	vpsubw	%ymm1, %ymm14, %ymm1
               	vmovups	%ymm0, 0x180(%rdi)
               	vmovups	%ymm1, 0x1a0(%rdi)
               	vpcmpeqd	%ymm0, %ymm0, %ymm0
               	vmovups	(%rsp), %ymm1
               	vpxor	%ymm0, %ymm1, %ymm1
               	vmovups	0x20(%rsp), %ymm2
               	vpxor	%ymm0, %ymm2, %ymm0
               	vmovups	%ymm1, 0x1c0(%rdi)
               	vmovups	%ymm0, 0x1e0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vpsllw	$0x3, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpsllw	$0x3, %ymm1, %ymm1
               	vmovups	%ymm0, 0x200(%rdi)
               	vmovups	%ymm1, 0x220(%rdi)
               	vmovups	(%rsp), %ymm0
               	vpsraw	$0x5, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpsraw	$0x5, %ymm1, %ymm1
               	vmovups	%ymm0, 0x240(%rdi)
               	vmovups	%ymm1, 0x260(%rdi)
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	(%rsp), %ymm1
               	vpcmpgtw	%ymm1, %ymm0, %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovups	0x20(%rsp), %ymm2
               	vpcmpgtw	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x280(%rdi)
               	vmovups	%ymm1, 0x2a0(%rdi)
               	leaq	0x2c0(%rdi), %rax
               	leaq	0x80(%rsp), %rcx
               	movswq	(%rsp), %rdx
               	movswq	0x40(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x80(%rsp)
               	movswq	0x2(%rsp), %rdx
               	movswq	0x42(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x82(%rsp)
               	movswq	0x4(%rsp), %rdx
               	movswq	0x44(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x84(%rsp)
               	movswq	0x6(%rsp), %rdx
               	movswq	0x46(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x86(%rsp)
               	movswq	0x8(%rsp), %rdx
               	movswq	0x48(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x88(%rsp)
               	movswq	0xa(%rsp), %rdx
               	movswq	0x4a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x8a(%rsp)
               	movswq	0xc(%rsp), %rdx
               	movswq	0x4c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x8c(%rsp)
               	movswq	0xe(%rsp), %rdx
               	movswq	0x4e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x8e(%rsp)
               	movswq	0x10(%rsp), %rdx
               	movswq	0x50(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x90(%rsp)
               	movswq	0x12(%rsp), %rdx
               	movswq	0x52(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x92(%rsp)
               	movswq	0x14(%rsp), %rdx
               	movswq	0x54(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x94(%rsp)
               	movswq	0x16(%rsp), %rdx
               	movswq	0x56(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x96(%rsp)
               	movswq	0x18(%rsp), %rdx
               	movswq	0x58(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x98(%rsp)
               	movswq	0x1a(%rsp), %rdx
               	movswq	0x5a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x9a(%rsp)
               	movswq	0x1c(%rsp), %rdx
               	movswq	0x5c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x9c(%rsp)
               	movswq	0x1e(%rsp), %rdx
               	movswq	0x5e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x9e(%rsp)
               	movswq	0x20(%rsp), %rdx
               	movswq	0x60(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xa0(%rsp)
               	movswq	0x22(%rsp), %rdx
               	movswq	0x62(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xa2(%rsp)
               	movswq	0x24(%rsp), %rdx
               	movswq	0x64(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xa4(%rsp)
               	movswq	0x26(%rsp), %rdx
               	movswq	0x66(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xa6(%rsp)
               	movswq	0x28(%rsp), %rdx
               	movswq	0x68(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xa8(%rsp)
               	movswq	0x2a(%rsp), %rdx
               	movswq	0x6a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xaa(%rsp)
               	movswq	0x2c(%rsp), %rdx
               	movswq	0x6c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xac(%rsp)
               	movswq	0x2e(%rsp), %rdx
               	movswq	0x6e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xae(%rsp)
               	movswq	0x30(%rsp), %rdx
               	movswq	0x70(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xb0(%rsp)
               	movswq	0x32(%rsp), %rdx
               	movswq	0x72(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xb2(%rsp)
               	movswq	0x34(%rsp), %rdx
               	movswq	0x74(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xb4(%rsp)
               	movswq	0x36(%rsp), %rdx
               	movswq	0x76(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xb6(%rsp)
               	movswq	0x38(%rsp), %rdx
               	movswq	0x78(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xb8(%rsp)
               	movswq	0x3a(%rsp), %rdx
               	movswq	0x7a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xba(%rsp)
               	movswq	0x3c(%rsp), %rdx
               	movswq	0x7c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xbc(%rsp)
               	movswq	0x3e(%rsp), %rdx
               	movswq	0x7e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xbe(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpcmpeqw	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpcmpeqw	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x300(%rdi)
               	vmovups	%ymm1, 0x320(%rdi)
               	vzeroupper
               	leave
               	retq

<check_s16x32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x3c0, %rsp            # imm = 0x3C0
               	andq	$-0x40, %rsp
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movw	%cx, 0x40(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movw	%di, (%rsp,%rax,2)
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	shrq	$0x20, %r8
               	leaq	(%r8,%r8,2), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movswq	%cx, %rcx
               	jmp	<addr>
               	movswq	(%rsp,%rax,2), %rcx
               	jmp	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movswq	(%rsp,%rax,2), %rcx
               	movswq	0x40(%rsp,%rax,2), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movswq	%si, %rsi
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movswq	%di, %rdi
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	movswq	%r8w, %r8
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	movswq	%r9w, %r9
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	xorl	%edx, %edx
               	movq	%rcx, %r13
               	negq	%r13
               	movswq	%r13w, %r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	shlq	$0x3, %rcx
               	movswq	%cx, %rcx
               	movswq	(%rsp,%rax,2), %r15
               	sarq	$0x5, %r15
               	movswq	(%rsp,%rax,2), %r10
               	movq	%r10, -0x8(%rbp)
               	movswq	0x40(%rsp,%rax,2), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	-0x8(%rbp), %r10
               	cmpl	-0x10(%rbp), %r10d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	negq	%r10
               	movq	%r10, -0x8(%rbp)
               	movswq	(%rsp,%rax,2), %r10
               	movq	%r10, -0x10(%rbp)
               	movswq	0x40(%rsp,%rax,2), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x10(%rbp), %r10
               	cmpl	-0x18(%rbp), %r10d
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	negq	%r10
               	movq	%r10, -0x10(%rbp)
               	movswq	(%rsp,%rax,2), %r10
               	movq	%r10, -0x18(%rbp)
               	movswq	0x40(%rsp,%rax,2), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x18(%rbp), %r10
               	cmpl	-0x20(%rbp), %r10d
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	negq	%r10
               	movq	%r10, -0x18(%rbp)
               	movswq	0x80(%rsp,%rax,2), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpl	%r10d, %esi
               	jne	<addr>
               	movl	$0x1, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x40, %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x80, %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	$0x3, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0xc0, %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	$0x4, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x100, %rsi            # imm = 0x100
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	%ebx, %esi
               	jne	<addr>
               	movl	$0x5, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x140, %rsi            # imm = 0x140
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	%r12d, %esi
               	jne	<addr>
               	movl	$0x6, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x180, %rsi            # imm = 0x180
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	%r13d, %esi
               	jne	<addr>
               	movl	$0x7, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x1c0, %rsi            # imm = 0x1C0
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	%r14d, %esi
               	jne	<addr>
               	movl	$0x8, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x200, %rsi            # imm = 0x200
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movl	$0x9, %edx
               	leaq	0x80(%rsp), %rcx
               	leaq	0x240(%rcx), %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	%r15d, %esi
               	jne	<addr>
               	movl	$0xa, %edx
               	addq	$0x280, %rcx            # imm = 0x280
               	movswq	(%rcx,%rax,2), %rcx
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %edx
               	leaq	0x80(%rsp), %rcx
               	leaq	0x2c0(%rcx), %rsi
               	movswq	(%rsi,%rax,2), %rsi
               	cmpl	-0x10(%rbp), %esi
               	jne	<addr>
               	movl	$0xc, %edx
               	addq	$0x300, %rcx            # imm = 0x300
               	movswq	(%rcx,%rax,2), %rcx
               	cmpl	-0x18(%rbp), %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x40(%rdx), %rax
               	incq	%rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<ops_s32x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpaddd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsubd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rdi)
               	leaq	0x40(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	vmovd	%xmm1, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rdx
               	movl	%edx, -0x20(%rbp)
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpextrd	$0x1, %xmm1, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rdx
               	movl	%edx, -0x1c(%rbp)
               	vpextrd	$0x2, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpextrd	$0x2, %xmm1, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rdx
               	movl	%edx, -0x18(%rbp)
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpextrd	$0x3, %xmm1, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rdx
               	movl	%edx, -0x14(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vmovd	%xmm2, %edx
               	movslq	%edx, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vmovd	%xmm2, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x1, %xmm2, %edx
               	movslq	%edx, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x1, %xmm2, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rdx
               	movl	%edx, -0xc(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x2, %xmm2, %edx
               	movslq	%edx, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x2, %xmm2, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rdx
               	movl	%edx, -0x8(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x3, %xmm2, %edx
               	movslq	%edx, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x3, %xmm2, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rdx
               	movl	%edx, -0x4(%rbp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpand	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rdi)
               	vpor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rdi)
               	vpxor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xa0(%rdi)
               	xorl	%eax, %eax
               	vmovq	%rax, %xmm14
               	vpsubd	%ymm0, %ymm14, %ymm2
               	vmovups	%ymm2, 0xc0(%rdi)
               	vpcmpeqd	%ymm2, %ymm2, %ymm2
               	vpxor	%ymm2, %ymm0, %ymm2
               	vmovups	%ymm2, 0xe0(%rdi)
               	vpslld	$0x3, %ymm0, %ymm2
               	vmovups	%ymm2, 0x100(%rdi)
               	vpsrad	$0x5, %ymm0, %ymm2
               	vmovups	%ymm2, 0x120(%rdi)
               	vpcmpgtd	%ymm0, %ymm1, %ymm2
               	vmovups	%ymm2, 0x140(%rdi)
               	leaq	0x160(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	vmovd	%xmm1, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, -0x20(%rbp)
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpextrd	$0x1, %xmm1, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, -0x1c(%rbp)
               	vpextrd	$0x2, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpextrd	$0x2, %xmm1, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, -0x18(%rbp)
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpextrd	$0x3, %xmm1, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, -0x14(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vmovd	%xmm2, %edx
               	movslq	%edx, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vmovd	%xmm2, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, -0x10(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x1, %xmm2, %edx
               	movslq	%edx, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x1, %xmm2, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, -0xc(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x2, %xmm2, %edx
               	movslq	%edx, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x2, %xmm2, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, -0x8(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x3, %xmm2, %edx
               	movslq	%edx, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x3, %xmm2, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, -0x4(%rbp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpcmpeqd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x180(%rdi)
               	vzeroupper
               	leave
               	retq

<check_s32x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x1e0, %rsp            # imm = 0x1E0
               	andq	$-0x20, %rsp
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movl	%ecx, 0x20(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movl	%edi, (%rsp,%rax,4)
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	shrq	$0x20, %r8
               	leaq	(%r8,%r8,2), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	jmp	<addr>
               	movl	(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	(%rsp,%rax,4), %ecx
               	movl	0x20(%rsp,%rax,4), %edx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	xorl	%edx, %edx
               	movq	%rcx, %r13
               	negq	%r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	shlq	$0x3, %rcx
               	movslq	(%rsp,%rax,4), %r15
               	sarq	$0x5, %r15
               	movl	(%rsp,%rax,4), %r10d
               	movq	%r10, -0x8(%rbp)
               	movl	0x20(%rsp,%rax,4), %r10d
               	movq	%r10, -0x10(%rbp)
               	movq	-0x8(%rbp), %r10
               	cmpl	-0x10(%rbp), %r10d
               	setl	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	negq	%r10
               	movq	%r10, -0x8(%rbp)
               	movl	(%rsp,%rax,4), %r10d
               	movq	%r10, -0x10(%rbp)
               	movl	0x20(%rsp,%rax,4), %r10d
               	movq	%r10, -0x18(%rbp)
               	movq	-0x10(%rbp), %r10
               	cmpl	-0x18(%rbp), %r10d
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	negq	%r10
               	movq	%r10, -0x10(%rbp)
               	movl	(%rsp,%rax,4), %r10d
               	movq	%r10, -0x18(%rbp)
               	movl	0x20(%rsp,%rax,4), %r10d
               	movq	%r10, -0x20(%rbp)
               	movq	-0x18(%rbp), %r10
               	cmpl	-0x20(%rbp), %r10d
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	negq	%r10
               	movq	%r10, -0x18(%rbp)
               	movl	0x40(%rsp,%rax,4), %r10d
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpl	%r10d, %esi
               	jne	<addr>
               	movl	$0x1, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x20, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x40, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	$0x3, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x60, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	$0x4, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x80, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%ebx, %esi
               	jne	<addr>
               	movl	$0x5, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xa0, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r12d, %esi
               	jne	<addr>
               	movl	$0x6, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xc0, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r13d, %esi
               	jne	<addr>
               	movl	$0x7, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xe0, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r14d, %esi
               	jne	<addr>
               	movl	$0x8, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x100, %rsi            # imm = 0x100
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movl	$0x9, %edx
               	leaq	0x40(%rsp), %rcx
               	leaq	0x120(%rcx), %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r15d, %esi
               	jne	<addr>
               	movl	$0xa, %edx
               	addq	$0x140, %rcx            # imm = 0x140
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %edx
               	leaq	0x40(%rsp), %rcx
               	leaq	0x160(%rcx), %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	-0x10(%rbp), %esi
               	jne	<addr>
               	movl	$0xc, %edx
               	addq	$0x180, %rcx            # imm = 0x180
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	-0x18(%rbp), %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x50(%rdx), %rax
               	incq	%rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<ops_u32x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rsi), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x40(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpaddd	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpaddd	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, (%rdi)
               	vmovups	%ymm1, 0x20(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpsubd	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpsubd	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x40(%rdi)
               	vmovups	%ymm1, 0x60(%rdi)
               	leaq	0x80(%rdi), %rax
               	leaq	0x80(%rsp), %rcx
               	movl	(%rsp), %edx
               	movl	0x40(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x80(%rsp)
               	movl	0x4(%rsp), %edx
               	movl	0x44(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x84(%rsp)
               	movl	0x8(%rsp), %edx
               	movl	0x48(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x88(%rsp)
               	movl	0xc(%rsp), %edx
               	movl	0x4c(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x8c(%rsp)
               	movl	0x10(%rsp), %edx
               	movl	0x50(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x90(%rsp)
               	movl	0x14(%rsp), %edx
               	movl	0x54(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x94(%rsp)
               	movl	0x18(%rsp), %edx
               	movl	0x58(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x98(%rsp)
               	movl	0x1c(%rsp), %edx
               	movl	0x5c(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x9c(%rsp)
               	movl	0x20(%rsp), %edx
               	movl	0x60(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0xa0(%rsp)
               	movl	0x24(%rsp), %edx
               	movl	0x64(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0xa4(%rsp)
               	movl	0x28(%rsp), %edx
               	movl	0x68(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0xa8(%rsp)
               	movl	0x2c(%rsp), %edx
               	movl	0x6c(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0xac(%rsp)
               	movl	0x30(%rsp), %edx
               	movl	0x70(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0xb0(%rsp)
               	movl	0x34(%rsp), %edx
               	movl	0x74(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0xb4(%rsp)
               	movl	0x38(%rsp), %edx
               	movl	0x78(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0xb8(%rsp)
               	movl	0x3c(%rsp), %edx
               	movl	0x7c(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0xbc(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpand	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpand	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0xc0(%rdi)
               	vmovups	%ymm1, 0xe0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpor	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpor	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x100(%rdi)
               	vmovups	%ymm1, 0x120(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpxor	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpxor	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x140(%rdi)
               	vmovups	%ymm1, 0x160(%rdi)
               	xorl	%eax, %eax
               	vmovups	(%rsp), %ymm0
               	vmovq	%rax, %xmm14
               	vpsubd	%ymm0, %ymm14, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovq	%rax, %xmm14
               	vpsubd	%ymm1, %ymm14, %ymm1
               	vmovups	%ymm0, 0x180(%rdi)
               	vmovups	%ymm1, 0x1a0(%rdi)
               	vpcmpeqd	%ymm0, %ymm0, %ymm0
               	vmovups	(%rsp), %ymm1
               	vpxor	%ymm0, %ymm1, %ymm1
               	vmovups	0x20(%rsp), %ymm2
               	vpxor	%ymm0, %ymm2, %ymm0
               	vmovups	%ymm1, 0x1c0(%rdi)
               	vmovups	%ymm0, 0x1e0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vpslld	$0x3, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpslld	$0x3, %ymm1, %ymm1
               	vmovups	%ymm0, 0x200(%rdi)
               	vmovups	%ymm1, 0x220(%rdi)
               	vmovups	(%rsp), %ymm0
               	vpsrld	$0x5, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpsrld	$0x5, %ymm1, %ymm1
               	vmovups	%ymm0, 0x240(%rdi)
               	vmovups	%ymm1, 0x260(%rdi)
               	leaq	0x280(%rdi), %rax
               	leaq	0x80(%rsp), %rcx
               	movl	(%rsp), %edx
               	movl	0x40(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x80(%rsp)
               	movl	0x4(%rsp), %edx
               	movl	0x44(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x84(%rsp)
               	movl	0x8(%rsp), %edx
               	movl	0x48(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x88(%rsp)
               	movl	0xc(%rsp), %edx
               	movl	0x4c(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x8c(%rsp)
               	movl	0x10(%rsp), %edx
               	movl	0x50(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x90(%rsp)
               	movl	0x14(%rsp), %edx
               	movl	0x54(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x94(%rsp)
               	movl	0x18(%rsp), %edx
               	movl	0x58(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x98(%rsp)
               	movl	0x1c(%rsp), %edx
               	movl	0x5c(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x9c(%rsp)
               	movl	0x20(%rsp), %edx
               	movl	0x60(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xa0(%rsp)
               	movl	0x24(%rsp), %edx
               	movl	0x64(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xa4(%rsp)
               	movl	0x28(%rsp), %edx
               	movl	0x68(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xa8(%rsp)
               	movl	0x2c(%rsp), %edx
               	movl	0x6c(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xac(%rsp)
               	movl	0x30(%rsp), %edx
               	movl	0x70(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xb0(%rsp)
               	movl	0x34(%rsp), %edx
               	movl	0x74(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xb4(%rsp)
               	movl	0x38(%rsp), %edx
               	movl	0x78(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xb8(%rsp)
               	movl	0x3c(%rsp), %edx
               	movl	0x7c(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xbc(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x2c0(%rdi), %rax
               	leaq	0x80(%rsp), %rcx
               	movl	(%rsp), %edx
               	movl	0x40(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x80(%rsp)
               	movl	0x4(%rsp), %edx
               	movl	0x44(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x84(%rsp)
               	movl	0x8(%rsp), %edx
               	movl	0x48(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x88(%rsp)
               	movl	0xc(%rsp), %edx
               	movl	0x4c(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x8c(%rsp)
               	movl	0x10(%rsp), %edx
               	movl	0x50(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x90(%rsp)
               	movl	0x14(%rsp), %edx
               	movl	0x54(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x94(%rsp)
               	movl	0x18(%rsp), %edx
               	movl	0x58(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x98(%rsp)
               	movl	0x1c(%rsp), %edx
               	movl	0x5c(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x9c(%rsp)
               	movl	0x20(%rsp), %edx
               	movl	0x60(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xa0(%rsp)
               	movl	0x24(%rsp), %edx
               	movl	0x64(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xa4(%rsp)
               	movl	0x28(%rsp), %edx
               	movl	0x68(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xa8(%rsp)
               	movl	0x2c(%rsp), %edx
               	movl	0x6c(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xac(%rsp)
               	movl	0x30(%rsp), %edx
               	movl	0x70(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xb0(%rsp)
               	movl	0x34(%rsp), %edx
               	movl	0x74(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xb4(%rsp)
               	movl	0x38(%rsp), %edx
               	movl	0x78(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xb8(%rsp)
               	movl	0x3c(%rsp), %edx
               	movl	0x7c(%rsp), %esi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xbc(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpcmpeqd	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpcmpeqd	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x300(%rdi)
               	vmovups	%ymm1, 0x320(%rdi)
               	vzeroupper
               	leave
               	retq

<check_u32x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x3c0, %rsp            # imm = 0x3C0
               	andq	$-0x40, %rsp
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movl	%ecx, 0x40(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movl	%edi, (%rsp,%rax,4)
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	shrq	$0x20, %r8
               	leaq	(%r8,%r8,2), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	jmp	<addr>
               	movl	(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	(%rsp,%rax,4), %ecx
               	movl	0x40(%rsp,%rax,4), %edx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	xorl	%edx, %edx
               	movq	%rcx, %r13
               	negq	%r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	shlq	$0x3, %rcx
               	movl	(%rsp,%rax,4), %r15d
               	shrq	$0x5, %r15
               	movl	(%rsp,%rax,4), %r10d
               	movq	%r10, -0x8(%rbp)
               	movl	0x40(%rsp,%rax,4), %r10d
               	movq	%r10, -0x10(%rbp)
               	movq	-0x8(%rbp), %r10
               	cmpl	-0x10(%rbp), %r10d
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	negq	%r10
               	movq	%r10, -0x8(%rbp)
               	movl	(%rsp,%rax,4), %r10d
               	movq	%r10, -0x10(%rbp)
               	movl	0x40(%rsp,%rax,4), %r10d
               	movq	%r10, -0x18(%rbp)
               	movq	-0x10(%rbp), %r10
               	cmpl	-0x18(%rbp), %r10d
               	setae	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	negq	%r10
               	movq	%r10, -0x10(%rbp)
               	movl	(%rsp,%rax,4), %r10d
               	movq	%r10, -0x18(%rbp)
               	movl	0x40(%rsp,%rax,4), %r10d
               	movq	%r10, -0x20(%rbp)
               	movq	-0x18(%rbp), %r10
               	cmpl	-0x20(%rbp), %r10d
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	negq	%r10
               	movq	%r10, -0x18(%rbp)
               	movl	0x80(%rsp,%rax,4), %r10d
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpl	%r10d, %esi
               	jne	<addr>
               	movl	$0x1, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x40, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x80, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	$0x3, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0xc0, %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	$0x4, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x100, %rsi            # imm = 0x100
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%ebx, %esi
               	jne	<addr>
               	movl	$0x5, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x140, %rsi            # imm = 0x140
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r12d, %esi
               	jne	<addr>
               	movl	$0x6, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x180, %rsi            # imm = 0x180
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r13d, %esi
               	jne	<addr>
               	movl	$0x7, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x1c0, %rsi            # imm = 0x1C0
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r14d, %esi
               	jne	<addr>
               	movl	$0x8, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x200, %rsi            # imm = 0x200
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movl	$0x9, %edx
               	leaq	0x80(%rsp), %rcx
               	leaq	0x240(%rcx), %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	%r15d, %esi
               	jne	<addr>
               	movl	$0xa, %edx
               	addq	$0x280, %rcx            # imm = 0x280
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %edx
               	leaq	0x80(%rsp), %rcx
               	leaq	0x2c0(%rcx), %rsi
               	movl	(%rsi,%rax,4), %esi
               	cmpl	-0x10(%rbp), %esi
               	jne	<addr>
               	movl	$0xc, %edx
               	addq	$0x300, %rcx            # imm = 0x300
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	-0x18(%rbp), %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x60(%rdx), %rax
               	incq	%rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<ops_u64x4>:
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpaddq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsubq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rdi)
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %rcx
               	imulq	%rcx, %rax
               	vpextrq	$0x1, %xmm0, %rcx
               	vpextrq	$0x1, %xmm1, %rdx
               	imulq	%rdx, %rcx
               	vextracti128	$0x1, %ymm0, %xmm2
               	vmovq	%xmm2, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vmovq	%xmm2, %rsi
               	imulq	%rsi, %rdx
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrq	$0x1, %xmm2, %rsi
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrq	$0x1, %xmm2, %r8
               	imulq	%r8, %rsi
               	movq	%rax, 0x40(%rdi)
               	movq	%rcx, 0x48(%rdi)
               	movq	%rdx, 0x50(%rdi)
               	movq	%rsi, 0x58(%rdi)
               	vpand	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rdi)
               	vpor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rdi)
               	vpxor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xa0(%rdi)
               	xorl	%eax, %eax
               	vmovq	%rax, %xmm14
               	vpsubq	%ymm0, %ymm14, %ymm2
               	vmovups	%ymm2, 0xc0(%rdi)
               	vpcmpeqd	%ymm2, %ymm2, %ymm2
               	vpxor	%ymm2, %ymm0, %ymm2
               	vmovups	%ymm2, 0xe0(%rdi)
               	vpsllq	$0x3, %ymm0, %ymm2
               	vmovups	%ymm2, 0x100(%rdi)
               	vpsrlq	$0x5, %ymm0, %ymm2
               	vmovups	%ymm2, 0x120(%rdi)
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %rcx
               	cmpq	%rcx, %rax
               	setb	%al
               	movzbq	%al, %rax
               	negq	%rax
               	vpextrq	$0x1, %xmm0, %rcx
               	vpextrq	$0x1, %xmm1, %rdx
               	cmpq	%rdx, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	vextracti128	$0x1, %ymm0, %xmm2
               	vmovq	%xmm2, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vmovq	%xmm2, %rsi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrq	$0x1, %xmm2, %rsi
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrq	$0x1, %xmm2, %r8
               	cmpq	%r8, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rax, 0x140(%rdi)
               	movq	%rcx, 0x148(%rdi)
               	movq	%rdx, 0x150(%rdi)
               	movq	%rsi, 0x158(%rdi)
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %rcx
               	cmpq	%rcx, %rax
               	setae	%al
               	movzbq	%al, %rax
               	negq	%rax
               	vpextrq	$0x1, %xmm0, %rcx
               	vpextrq	$0x1, %xmm1, %rdx
               	cmpq	%rdx, %rcx
               	setae	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	vextracti128	$0x1, %ymm0, %xmm2
               	vmovq	%xmm2, %rdx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vmovq	%xmm2, %rsi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrq	$0x1, %xmm2, %rsi
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrq	$0x1, %xmm2, %r8
               	cmpq	%r8, %rsi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rax, 0x160(%rdi)
               	movq	%rcx, 0x168(%rdi)
               	movq	%rdx, 0x170(%rdi)
               	movq	%rsi, 0x178(%rdi)
               	vpcmpeqq	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x180(%rdi)
               	vzeroupper
               	retq

<check_u64x4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x1e0, %rsp            # imm = 0x1E0
               	andq	$-0x20, %rsp
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movq	%rcx, 0x20(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, (%rsp,%rax,8)
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	shrq	$0x20, %r8
               	leaq	(%r8,%r8,2), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	jmp	<addr>
               	movq	(%rsp,%rax,8), %rcx
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	(%rsp,%rax,8), %rcx
               	movq	0x20(%rsp,%rax,8), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	xorl	%edx, %edx
               	movq	%rcx, %r13
               	negq	%r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	shlq	$0x3, %rcx
               	movq	(%rsp,%rax,8), %r15
               	shrq	$0x5, %r15
               	movq	(%rsp,%rax,8), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	0x20(%rsp,%rax,8), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	-0x8(%rbp), %r10
               	cmpq	-0x10(%rbp), %r10
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	negq	%r10
               	movq	%r10, -0x8(%rbp)
               	movq	(%rsp,%rax,8), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rsp,%rax,8), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x10(%rbp), %r10
               	cmpq	-0x18(%rbp), %r10
               	setae	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	negq	%r10
               	movq	%r10, -0x10(%rbp)
               	movq	(%rsp,%rax,8), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rsp,%rax,8), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x18(%rbp), %r10
               	cmpq	-0x20(%rbp), %r10
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	negq	%r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x40(%rsp,%rax,8), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpq	%r10, %rsi
               	jne	<addr>
               	movl	$0x1, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x20, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	$0x2, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x40, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r8, %rsi
               	jne	<addr>
               	movl	$0x3, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x60, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r9, %rsi
               	jne	<addr>
               	movl	$0x4, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x80, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%rbx, %rsi
               	jne	<addr>
               	movl	$0x5, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xa0, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r12, %rsi
               	jne	<addr>
               	movl	$0x6, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xc0, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r13, %rsi
               	jne	<addr>
               	movl	$0x7, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0xe0, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r14, %rsi
               	jne	<addr>
               	movl	$0x8, %edx
               	leaq	0x40(%rsp), %rsi
               	addq	$0x100, %rsi            # imm = 0x100
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movl	$0x9, %edx
               	leaq	0x40(%rsp), %rcx
               	leaq	0x120(%rcx), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r15, %rsi
               	jne	<addr>
               	movl	$0xa, %edx
               	addq	$0x140, %rcx            # imm = 0x140
               	movq	(%rcx,%rax,8), %rcx
               	cmpq	-0x8(%rbp), %rcx
               	jne	<addr>
               	movl	$0xb, %edx
               	leaq	0x40(%rsp), %rcx
               	leaq	0x160(%rcx), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	-0x10(%rbp), %rsi
               	jne	<addr>
               	movl	$0xc, %edx
               	addq	$0x180, %rcx            # imm = 0x180
               	movq	(%rcx,%rax,8), %rcx
               	cmpq	-0x18(%rbp), %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x70(%rdx), %rax
               	incq	%rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<ops_s64x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rsi), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x40(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpaddq	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpaddq	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, (%rdi)
               	vmovups	%ymm1, 0x20(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpsubq	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpsubq	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x40(%rdi)
               	vmovups	%ymm1, 0x60(%rdi)
               	movq	(%rsp), %rax
               	movq	0x40(%rsp), %rcx
               	imulq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x48(%rsp), %rdx
               	imulq	%rdx, %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x50(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x58(%rsp), %r8
               	imulq	%r8, %rsi
               	movq	0x20(%rsp), %r8
               	movq	0x60(%rsp), %r9
               	imulq	%r9, %r8
               	movq	0x28(%rsp), %r9
               	movq	0x68(%rsp), %rbx
               	imulq	%rbx, %r9
               	movq	0x30(%rsp), %rbx
               	movq	0x70(%rsp), %r12
               	imulq	%r12, %rbx
               	movq	0x38(%rsp), %r12
               	movq	0x78(%rsp), %r13
               	imulq	%r13, %r12
               	movq	%rax, 0x80(%rdi)
               	movq	%rcx, 0x88(%rdi)
               	movq	%rdx, 0x90(%rdi)
               	movq	%rsi, 0x98(%rdi)
               	movq	%r8, 0xa0(%rdi)
               	movq	%r9, 0xa8(%rdi)
               	movq	%rbx, 0xb0(%rdi)
               	movq	%r12, 0xb8(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpand	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpand	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0xc0(%rdi)
               	vmovups	%ymm1, 0xe0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpor	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpor	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x100(%rdi)
               	vmovups	%ymm1, 0x120(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpxor	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpxor	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x140(%rdi)
               	vmovups	%ymm1, 0x160(%rdi)
               	xorl	%eax, %eax
               	vmovups	(%rsp), %ymm0
               	vmovq	%rax, %xmm14
               	vpsubq	%ymm0, %ymm14, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovq	%rax, %xmm14
               	vpsubq	%ymm1, %ymm14, %ymm1
               	vmovups	%ymm0, 0x180(%rdi)
               	vmovups	%ymm1, 0x1a0(%rdi)
               	vpcmpeqd	%ymm0, %ymm0, %ymm0
               	vmovups	(%rsp), %ymm1
               	vpxor	%ymm0, %ymm1, %ymm1
               	vmovups	0x20(%rsp), %ymm2
               	vpxor	%ymm0, %ymm2, %ymm0
               	vmovups	%ymm1, 0x1c0(%rdi)
               	vmovups	%ymm0, 0x1e0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vpsllq	$0x3, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpsllq	$0x3, %ymm1, %ymm1
               	vmovups	%ymm0, 0x200(%rdi)
               	vmovups	%ymm1, 0x220(%rdi)
               	movq	(%rsp), %rax
               	sarq	$0x5, %rax
               	movq	0x8(%rsp), %rcx
               	sarq	$0x5, %rcx
               	movq	0x10(%rsp), %rdx
               	sarq	$0x5, %rdx
               	movq	0x18(%rsp), %rsi
               	sarq	$0x5, %rsi
               	movq	0x20(%rsp), %r8
               	sarq	$0x5, %r8
               	movq	0x28(%rsp), %r9
               	sarq	$0x5, %r9
               	movq	0x30(%rsp), %rbx
               	sarq	$0x5, %rbx
               	movq	0x38(%rsp), %r12
               	sarq	$0x5, %r12
               	movq	%rax, 0x240(%rdi)
               	movq	%rcx, 0x248(%rdi)
               	movq	%rdx, 0x250(%rdi)
               	movq	%rsi, 0x258(%rdi)
               	movq	%r8, 0x260(%rdi)
               	movq	%r9, 0x268(%rdi)
               	movq	%rbx, 0x270(%rdi)
               	movq	%r12, 0x278(%rdi)
               	vmovups	0x40(%rsp), %ymm0
               	vmovups	(%rsp), %ymm1
               	vpcmpgtq	%ymm1, %ymm0, %ymm0
               	vmovups	0x60(%rsp), %ymm1
               	vmovups	0x20(%rsp), %ymm2
               	vpcmpgtq	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x280(%rdi)
               	vmovups	%ymm1, 0x2a0(%rdi)
               	movq	(%rsp), %rax
               	movq	0x40(%rsp), %rcx
               	cmpq	%rcx, %rax
               	setge	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movq	0x8(%rsp), %rcx
               	movq	0x48(%rsp), %rdx
               	cmpq	%rdx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x50(%rsp), %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x58(%rsp), %r8
               	cmpq	%r8, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	0x20(%rsp), %r8
               	movq	0x60(%rsp), %r9
               	cmpq	%r9, %r8
               	setge	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movq	0x28(%rsp), %r9
               	movq	0x68(%rsp), %rbx
               	cmpq	%rbx, %r9
               	setge	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movq	0x30(%rsp), %rbx
               	movq	0x70(%rsp), %r12
               	cmpq	%r12, %rbx
               	setge	%bl
               	movzbq	%bl, %rbx
               	negq	%rbx
               	movq	0x38(%rsp), %r12
               	movq	0x78(%rsp), %r13
               	cmpq	%r13, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	negq	%r12
               	movq	%rax, 0x2c0(%rdi)
               	movq	%rcx, 0x2c8(%rdi)
               	movq	%rdx, 0x2d0(%rdi)
               	movq	%rsi, 0x2d8(%rdi)
               	movq	%r8, 0x2e0(%rdi)
               	movq	%r9, 0x2e8(%rdi)
               	movq	%rbx, 0x2f0(%rdi)
               	movq	%r12, 0x2f8(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vpcmpeqq	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vpcmpeqq	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x300(%rdi)
               	vmovups	%ymm1, 0x320(%rdi)
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	vzeroupper
               	leave
               	retq

<check_s64x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x3c0, %rsp            # imm = 0x3C0
               	andq	$-0x40, %rsp
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movq	%rcx, 0x40(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, (%rsp,%rax,8)
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	shrq	$0x20, %r8
               	leaq	(%r8,%r8,2), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	jmp	<addr>
               	movq	(%rsp,%rax,8), %rcx
               	jmp	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	(%rsp,%rax,8), %rcx
               	movq	0x40(%rsp,%rax,8), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	xorl	%edx, %edx
               	movq	%rcx, %r13
               	negq	%r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	shlq	$0x3, %rcx
               	movq	(%rsp,%rax,8), %r15
               	sarq	$0x5, %r15
               	movq	(%rsp,%rax,8), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	0x40(%rsp,%rax,8), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	-0x8(%rbp), %r10
               	cmpq	-0x10(%rbp), %r10
               	setl	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x8(%rbp)
               	negq	%r10
               	movq	%r10, -0x8(%rbp)
               	movq	(%rsp,%rax,8), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x40(%rsp,%rax,8), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x10(%rbp), %r10
               	cmpq	-0x18(%rbp), %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x10(%rbp)
               	negq	%r10
               	movq	%r10, -0x10(%rbp)
               	movq	(%rsp,%rax,8), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x40(%rsp,%rax,8), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x18(%rbp), %r10
               	cmpq	-0x20(%rbp), %r10
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x18(%rbp)
               	negq	%r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x80(%rsp,%rax,8), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpq	%r10, %rsi
               	jne	<addr>
               	movl	$0x1, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x40, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	$0x2, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x80, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r8, %rsi
               	jne	<addr>
               	movl	$0x3, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0xc0, %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r9, %rsi
               	jne	<addr>
               	movl	$0x4, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x100, %rsi            # imm = 0x100
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%rbx, %rsi
               	jne	<addr>
               	movl	$0x5, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x140, %rsi            # imm = 0x140
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r12, %rsi
               	jne	<addr>
               	movl	$0x6, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x180, %rsi            # imm = 0x180
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r13, %rsi
               	jne	<addr>
               	movl	$0x7, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x1c0, %rsi            # imm = 0x1C0
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r14, %rsi
               	jne	<addr>
               	movl	$0x8, %edx
               	leaq	0x80(%rsp), %rsi
               	addq	$0x200, %rsi            # imm = 0x200
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movl	$0x9, %edx
               	leaq	0x80(%rsp), %rcx
               	leaq	0x240(%rcx), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	%r15, %rsi
               	jne	<addr>
               	movl	$0xa, %edx
               	addq	$0x280, %rcx            # imm = 0x280
               	movq	(%rcx,%rax,8), %rcx
               	cmpq	-0x8(%rbp), %rcx
               	jne	<addr>
               	movl	$0xb, %edx
               	leaq	0x80(%rsp), %rcx
               	leaq	0x2c0(%rcx), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	cmpq	-0x10(%rbp), %rsi
               	jne	<addr>
               	movl	$0xc, %edx
               	addq	$0x300, %rcx            # imm = 0x300
               	movq	(%rcx,%rax,8), %rcx
               	cmpq	-0x18(%rbp), %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x80(%rdx), %rax
               	incq	%rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<ops_f32x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vaddps	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vsubps	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rdi)
               	vmulps	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rdi)
               	vdivps	%ymm1, %ymm0, %ymm1
               	vmovups	%ymm1, 0x60(%rdi)
               	leaq	0x80(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x20(%rbp)
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x1c(%rbp)
               	vpermilps	$0x2, %xmm0, %xmm1 # xmm1 = xmm0[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x18(%rbp)
               	vpermilps	$0x3, %xmm0, %xmm1 # xmm1 = xmm0[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x14(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x10(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpermilps	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0xc(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpermilps	$0x2, %xmm1, %xmm1 # xmm1 = xmm1[2,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	%xmm1, -0x8(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vzeroupper
               	leave
               	retq

<check_f32x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shrq	$0xb, %rsi
               	movabsq	$0x20c06a7159f065, %rcx # imm = 0x20C06A7159F065
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rsi
               	leaq	-0x3e8(%rsi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movabsq	$0x4189374bc6a7f0, %rsi # imm = 0x4189374BC6A7F0
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x34(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rsp)
               	leaq	0x20(%rsp), %r8
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rcx
               	leaq	0x1(%rcx), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x3c(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rbx
               	movq	%rbx, %rsi
               	movq	%r8, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	movss	(%rdx), %xmm1
               	leaq	0x20(%rsp), %rdx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm0
               	addss	%xmm0, %xmm1
               	leaq	(%rsp), %rdx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm2
               	subss	%xmm0, %xmm2
               	leaq	(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movss	(%rsi), %xmm0
               	leaq	0x20(%rsp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm3
               	vmulss	%xmm3, %xmm0, %xmm3
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm0
               	leaq	(%rsi,%rcx), %rdx
               	movss	(%rdx), %xmm4
               	vdivss	%xmm4, %xmm0, %xmm5
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	xorl	%edi, %edi
               	leaq	0x40(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movss	(%rsi), %xmm4
               	ucomiss	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %edi
               	addq	$0x20, %rdx
               	addq	%rdx, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	0x40(%rsp), %rcx
               	leaq	0x40(%rcx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm3, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	0x60(%rcx), %rsi
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm5, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %edi
               	addq	$0x80, %rcx
               	addq	%rdx, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	leaq	0x90(%rdi), %rax
               	incq	%rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<ops_f32x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rsi), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x40(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vaddps	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vaddps	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, (%rdi)
               	vmovups	%ymm1, 0x20(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vsubps	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vsubps	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x40(%rdi)
               	vmovups	%ymm1, 0x60(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vmulps	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vmulps	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x80(%rdi)
               	vmovups	%ymm1, 0xa0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vdivps	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vdivps	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0xc0(%rdi)
               	vmovups	%ymm1, 0xe0(%rdi)
               	leaq	0x100(%rdi), %rax
               	leaq	0x40(%rsp), %rcx
               	movss	(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x40(%rsp)
               	movss	0x4(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x44(%rsp)
               	movss	0x8(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movss	0xc(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x4c(%rsp)
               	movss	0x10(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x50(%rsp)
               	movss	0x14(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x54(%rsp)
               	movss	0x18(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x58(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x5c(%rsp)
               	movss	0x20(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x60(%rsp)
               	movss	0x24(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x64(%rsp)
               	movss	0x28(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x68(%rsp)
               	movss	0x2c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x6c(%rsp)
               	movss	0x30(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x70(%rsp)
               	movss	0x34(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x38(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x3c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x7c(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vzeroupper
               	leave
               	retq

<check_f32x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	andq	$-0x40, %rsp
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shrq	$0xb, %rsi
               	movabsq	$0x20c06a7159f065, %rcx # imm = 0x20C06A7159F065
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rsi
               	leaq	-0x3e8(%rsi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movabsq	$0x4189374bc6a7f0, %rsi # imm = 0x4189374BC6A7F0
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x44(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x4c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x50(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x54(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x58(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x5c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x60(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x64(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x68(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x6c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x70(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x34(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x74(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movss	<rip>, %xmm3
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x78(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x3c(%rsp)
               	leaq	0x40(%rsp), %r8
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rcx
               	leaq	0x1(%rcx), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	divss	%xmm3, %xmm0
               	movss	%xmm0, 0x7c(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rbx
               	movq	%rbx, %rsi
               	movq	%r8, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	movss	(%rdx), %xmm1
               	leaq	0x40(%rsp), %rdx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm0
               	addss	%xmm0, %xmm1
               	leaq	(%rsp), %rdx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm2
               	subss	%xmm0, %xmm2
               	leaq	(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movss	(%rsi), %xmm0
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm3
               	vmulss	%xmm3, %xmm0, %xmm3
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm0
               	leaq	(%rsi,%rcx), %rdx
               	movss	(%rdx), %xmm4
               	vdivss	%xmm4, %xmm0, %xmm5
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	xorl	%edi, %edi
               	leaq	0x80(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movss	(%rsi), %xmm4
               	ucomiss	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %edi
               	addq	$0x40, %rdx
               	addq	%rdx, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	0x80(%rsp), %rcx
               	leaq	0x80(%rcx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm3, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	0xc0(%rcx), %rsi
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm5, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %edi
               	addq	$0x100, %rcx            # imm = 0x100
               	addq	%rdx, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	leaq	0xa0(%rdi), %rax
               	incq	%rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<ops_f64x4>:
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vaddpd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vsubpd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rdi)
               	vmulpd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rdi)
               	vdivpd	%ymm1, %ymm0, %ymm1
               	vmovups	%ymm1, 0x60(%rdi)
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vpermilpd	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm1, 0x80(%rdi)
               	movsd	%xmm2, 0x88(%rdi)
               	movsd	%xmm3, 0x90(%rdi)
               	movsd	%xmm0, 0x98(%rdi)
               	vzeroupper
               	retq

<check_f64x4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shrq	$0xb, %rsi
               	movabsq	$0x20c06a7159f065, %rcx # imm = 0x20C06A7159F065
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rsi
               	leaq	-0x3e8(%rsi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	<rip>, %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movabsq	$0x4189374bc6a7f0, %rsi # imm = 0x4189374BC6A7F0
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movsd	<rip>, %xmm3
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	<rip>, %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movsd	<rip>, %xmm3
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x18(%rsp)
               	leaq	0x20(%rsp), %r8
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rcx
               	leaq	0x1(%rcx), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x38(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rbx
               	movq	%rbx, %rsi
               	movq	%r8, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	movsd	(%rdx), %xmm1
               	leaq	0x20(%rsp), %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm0
               	addsd	%xmm0, %xmm1
               	leaq	(%rsp), %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm2
               	subsd	%xmm0, %xmm2
               	leaq	(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movsd	(%rsi), %xmm0
               	leaq	0x20(%rsp), %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm3
               	vmulsd	%xmm3, %xmm0, %xmm3
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm0
               	leaq	(%rsi,%rcx), %rdx
               	movsd	(%rdx), %xmm4
               	vdivsd	%xmm4, %xmm0, %xmm5
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	xorl	%edi, %edi
               	leaq	0x40(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movsd	(%rsi), %xmm4
               	ucomisd	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %edi
               	addq	$0x20, %rdx
               	addq	%rdx, %rcx
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	0x40(%rsp), %rcx
               	leaq	0x40(%rcx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rsi
               	movsd	(%rsi), %xmm1
               	ucomisd	%xmm3, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	0x60(%rcx), %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi), %xmm1
               	ucomisd	%xmm5, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %edi
               	addq	$0x80, %rcx
               	addq	%rdx, %rcx
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	leaq	0xb0(%rdi), %rax
               	incq	%rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<ops_f64x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	vmovups	(%rsi), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rsi), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	0x40(%rsp), %rax
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vaddpd	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vaddpd	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, (%rdi)
               	vmovups	%ymm1, 0x20(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vsubpd	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vsubpd	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x40(%rdi)
               	vmovups	%ymm1, 0x60(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vmulpd	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vmulpd	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0x80(%rdi)
               	vmovups	%ymm1, 0xa0(%rdi)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x40(%rsp), %ymm1
               	vdivpd	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x60(%rsp), %ymm2
               	vdivpd	%ymm2, %ymm1, %ymm1
               	vmovups	%ymm0, 0xc0(%rdi)
               	vmovups	%ymm1, 0xe0(%rdi)
               	movsd	(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x8(%rsp), %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movsd	0x10(%rsp), %xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	movsd	0x18(%rsp), %xmm3
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm3
               	movsd	0x20(%rsp), %xmm4
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm4
               	movsd	0x28(%rsp), %xmm5
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm5
               	movsd	0x30(%rsp), %xmm6
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	movsd	0x38(%rsp), %xmm7
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm7
               	movsd	%xmm0, 0x100(%rdi)
               	movsd	%xmm1, 0x108(%rdi)
               	movsd	%xmm2, 0x110(%rdi)
               	movsd	%xmm3, 0x118(%rdi)
               	movsd	%xmm4, 0x120(%rdi)
               	movsd	%xmm5, 0x128(%rdi)
               	movsd	%xmm6, 0x130(%rdi)
               	movsd	%xmm7, 0x138(%rdi)
               	vzeroupper
               	leave
               	retq

<check_f64x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	andq	$-0x40, %rsp
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rsi
               	shrq	$0xb, %rsi
               	movabsq	$0x20c06a7159f065, %rcx # imm = 0x20C06A7159F065
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rsi
               	leaq	-0x3e8(%rsi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	<rip>, %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movabsq	$0x4189374bc6a7f0, %rsi # imm = 0x4189374BC6A7F0
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movsd	<rip>, %xmm3
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x40(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x48(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	<rip>, %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movsd	<rip>, %xmm3
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x50(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x58(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	<rip>, %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movsd	<rip>, %xmm3
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x60(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x68(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	<rip>, %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movsd	<rip>, %xmm3
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x70(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdi
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x38(%rsp)
               	leaq	0x40(%rsp), %r8
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rcx
               	leaq	0x1(%rcx), %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	divsd	%xmm3, %xmm0
               	movsd	%xmm0, 0x78(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rbx
               	movq	%rbx, %rsi
               	movq	%r8, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	movsd	(%rdx), %xmm1
               	leaq	0x40(%rsp), %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm0
               	addsd	%xmm0, %xmm1
               	leaq	(%rsp), %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm2
               	subsd	%xmm0, %xmm2
               	leaq	(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movsd	(%rsi), %xmm0
               	leaq	0x40(%rsp), %rsi
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm3
               	vmulsd	%xmm3, %xmm0, %xmm3
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm0
               	leaq	(%rsi,%rcx), %rdx
               	movsd	(%rdx), %xmm4
               	vdivsd	%xmm4, %xmm0, %xmm5
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	xorl	%edi, %edi
               	leaq	0x80(%rsp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	movsd	(%rsi), %xmm4
               	ucomisd	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %edi
               	addq	$0x40, %rdx
               	addq	%rdx, %rcx
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	0x80(%rsp), %rcx
               	leaq	0x80(%rcx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rsi
               	movsd	(%rsi), %xmm1
               	ucomisd	%xmm3, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	0xc0(%rcx), %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi), %xmm1
               	ucomisd	%xmm5, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %edi
               	addq	$0x100, %rcx            # imm = 0x100
               	addq	%rdx, %rcx
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	leaq	0xc0(%rdi), %rax
               	incq	%rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
