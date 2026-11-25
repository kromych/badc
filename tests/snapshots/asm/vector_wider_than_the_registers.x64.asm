
vector_wider_than_the_registers.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpaddb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsubb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rdi)
               	leaq	0x40(%rdi), %rcx
               	leaq	(%rsp), %rdx
               	vpextrb	$0x0, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x0, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, (%rsp)
               	vpextrb	$0x1, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x1, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x1(%rsp)
               	vpextrb	$0x2, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x2, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x2(%rsp)
               	vpextrb	$0x3, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x3, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x3(%rsp)
               	vpextrb	$0x4, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x4, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4(%rsp)
               	vpextrb	$0x5, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x5, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x5(%rsp)
               	vpextrb	$0x6, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x6, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x6(%rsp)
               	vpextrb	$0x7, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x7, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x7(%rsp)
               	vpextrb	$0x8, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x8, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x8(%rsp)
               	vpextrb	$0x9, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0x9, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x9(%rsp)
               	vpextrb	$0xa, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0xa, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa(%rsp)
               	vpextrb	$0xb, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0xb, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb(%rsp)
               	vpextrb	$0xc, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0xc, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xc(%rsp)
               	vpextrb	$0xd, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0xd, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xd(%rsp)
               	vpextrb	$0xe, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0xe, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xe(%rsp)
               	vpextrb	$0xf, %xmm0, %eax
               	movsbq	%al, %rax
               	vpextrb	$0xf, %xmm1, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xf(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x0, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x0, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x10(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x1, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x1, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x11(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x2, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x2, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x12(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x3, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x3, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x13(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x4, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x4, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x14(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x5, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x5, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x15(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x6, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x6, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x16(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x7, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x7, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x17(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x8, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x8, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x18(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x9, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0x9, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x19(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xa, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xa, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x1a(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xb, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xb, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x1b(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xc, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xc, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x1c(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xd, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xd, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x1d(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xe, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xe, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x1e(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xf, %xmm2, %eax
               	movsbq	%al, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrb	$0xf, %xmm2, %esi
               	movsbq	%sil, %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x1f(%rsp)
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
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
               	leaq	0x100(%rdi), %rcx
               	leaq	(%rsp), %rdx
               	vpextrb	$0x0, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, (%rsp)
               	vpextrb	$0x1, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x1(%rsp)
               	vpextrb	$0x2, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x2(%rsp)
               	vpextrb	$0x3, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x3(%rsp)
               	vpextrb	$0x4, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x4(%rsp)
               	vpextrb	$0x5, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x5(%rsp)
               	vpextrb	$0x6, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x6(%rsp)
               	vpextrb	$0x7, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x7(%rsp)
               	vpextrb	$0x8, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x8(%rsp)
               	vpextrb	$0x9, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x9(%rsp)
               	vpextrb	$0xa, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa(%rsp)
               	vpextrb	$0xb, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb(%rsp)
               	vpextrb	$0xc, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xc(%rsp)
               	vpextrb	$0xd, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xd(%rsp)
               	vpextrb	$0xe, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xe(%rsp)
               	vpextrb	$0xf, %xmm0, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xf(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x0, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x10(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x1, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x11(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x2, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x12(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x3, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x13(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x4, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x14(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x5, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x15(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x6, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x16(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x7, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x17(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x8, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x18(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x9, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x19(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xa, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x1a(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xb, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x1b(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xc, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x1c(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xd, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x1d(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xe, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x1e(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xf, %xmm2, %eax
               	movsbq	%al, %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x1f(%rsp)
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	leaq	0x120(%rdi), %rcx
               	leaq	(%rsp), %rdx
               	vpextrb	$0x0, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, (%rsp)
               	vpextrb	$0x1, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x1(%rsp)
               	vpextrb	$0x2, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x2(%rsp)
               	vpextrb	$0x3, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x3(%rsp)
               	vpextrb	$0x4, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x4(%rsp)
               	vpextrb	$0x5, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x5(%rsp)
               	vpextrb	$0x6, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x6(%rsp)
               	vpextrb	$0x7, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x7(%rsp)
               	vpextrb	$0x8, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x8(%rsp)
               	vpextrb	$0x9, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x9(%rsp)
               	vpextrb	$0xa, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0xa(%rsp)
               	vpextrb	$0xb, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0xb(%rsp)
               	vpextrb	$0xc, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0xc(%rsp)
               	vpextrb	$0xd, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0xd(%rsp)
               	vpextrb	$0xe, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0xe(%rsp)
               	vpextrb	$0xf, %xmm0, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0xf(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x0, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x10(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x1, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x11(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x2, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x12(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x3, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x13(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x4, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x14(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x5, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x15(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x6, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x16(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x7, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x17(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x8, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x18(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0x9, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x19(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xa, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x1a(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xb, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x1b(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xc, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x1c(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xd, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x1d(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xe, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x1e(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrb	$0xf, %xmm2, %eax
               	movsbq	%al, %rax
               	sarq	$0x5, %rax
               	movb	%al, 0x1f(%rsp)
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vpcmpgtb	%ymm0, %ymm1, %ymm2
               	vmovups	%ymm2, 0x140(%rdi)
               	leaq	0x160(%rdi), %rax
               	leaq	(%rsp), %rcx
               	vpextrb	$0x0, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x0, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, (%rsp)
               	vpextrb	$0x1, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x1, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x1(%rsp)
               	vpextrb	$0x2, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x2, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x2(%rsp)
               	vpextrb	$0x3, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x3, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x3(%rsp)
               	vpextrb	$0x4, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x4, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x4(%rsp)
               	vpextrb	$0x5, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x5, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x5(%rsp)
               	vpextrb	$0x6, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x6, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x6(%rsp)
               	vpextrb	$0x7, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x7, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x7(%rsp)
               	vpextrb	$0x8, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x8, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x8(%rsp)
               	vpextrb	$0x9, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x9, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x9(%rsp)
               	vpextrb	$0xa, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xa, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xa(%rsp)
               	vpextrb	$0xb, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xb, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xb(%rsp)
               	vpextrb	$0xc, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xc, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xc(%rsp)
               	vpextrb	$0xd, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xd, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xd(%rsp)
               	vpextrb	$0xe, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xe, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xe(%rsp)
               	vpextrb	$0xf, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xf, %xmm1, %esi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0xf(%rsp)
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
               	movb	%dl, 0x10(%rsp)
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
               	movb	%dl, 0x11(%rsp)
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
               	movb	%dl, 0x12(%rsp)
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
               	movb	%dl, 0x13(%rsp)
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
               	movb	%dl, 0x14(%rsp)
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
               	movb	%dl, 0x15(%rsp)
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
               	movb	%dl, 0x16(%rsp)
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
               	movb	%dl, 0x17(%rsp)
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
               	movb	%dl, 0x18(%rsp)
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
               	movb	%dl, 0x19(%rsp)
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
               	movb	%dl, 0x1a(%rsp)
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
               	movb	%dl, 0x1b(%rsp)
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
               	movb	%dl, 0x1c(%rsp)
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
               	movb	%dl, 0x1d(%rsp)
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
               	movb	%dl, 0x1e(%rsp)
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
               	movb	%dl, 0x1f(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpcmpeqb	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x180(%rdi)
               	vzeroupper
               	addq	$0x28, %rsp
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
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rdi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movb	%cl, 0x20(%rsp,%rax)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movb	%cl, (%rsp,%rax)
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movsbq	%cl, %rcx
               	jmp	<addr>
               	movsbq	%cl, %rcx
               	nop
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	(%rsp,%rax), %rcx
               	movsbq	0x20(%rsp,%rax), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movsbq	%sil, %rdi
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movsbq	%sil, %r8
               	movq	%rcx, %rsi
               	imulq	%rdx, %rsi
               	movsbq	%sil, %r9
               	movq	%rcx, %rsi
               	andq	%rdx, %rsi
               	movsbq	%sil, %rbx
               	movq	%rcx, %r12
               	orq	%rdx, %r12
               	xorq	%rcx, %rdx
               	xorl	%esi, %esi
               	movq	%rcx, %r13
               	negq	%r13
               	movsbq	%r13b, %r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	shlq	$0x3, %rcx
               	movsbq	%cl, %r15
               	movsbq	(%rsp,%rax), %rcx
               	sarq	$0x5, %rcx
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
               	movq	%rdi, %r10
               	movq	-0x20(%rbp), %rdi
               	cmpl	%r10d, %edi
               	jne	<addr>
               	movl	$0x1, %esi
               	leaq	0x40(%rsp), %rdi
               	addq	$0x20, %rdi
               	movsbq	(%rdi,%rax), %rdi
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x2, %esi
               	leaq	0x40(%rsp), %rdi
               	addq	$0x40, %rdi
               	movsbq	(%rdi,%rax), %rdi
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x3, %esi
               	leaq	0x40(%rsp), %rdi
               	addq	$0x60, %rdi
               	movsbq	(%rdi,%rax), %rdi
               	cmpl	%ebx, %edi
               	jne	<addr>
               	movl	$0x4, %esi
               	leaq	0x40(%rsp), %rdi
               	addq	$0x80, %rdi
               	movsbq	(%rdi,%rax), %rdi
               	cmpl	%r12d, %edi
               	jne	<addr>
               	movl	$0x5, %esi
               	leaq	0x40(%rsp), %rdi
               	addq	$0xa0, %rdi
               	movsbq	(%rdi,%rax), %rdi
               	cmpl	%edx, %edi
               	jne	<addr>
               	movl	$0x6, %esi
               	leaq	0x40(%rsp), %rdx
               	addq	$0xc0, %rdx
               	movsbq	(%rdx,%rax), %rdx
               	cmpl	%r13d, %edx
               	jne	<addr>
               	movl	$0x7, %esi
               	leaq	0x40(%rsp), %rdx
               	addq	$0xe0, %rdx
               	movsbq	(%rdx,%rax), %rdx
               	cmpl	%r14d, %edx
               	jne	<addr>
               	movl	$0x8, %esi
               	leaq	0x40(%rsp), %rdx
               	addq	$0x100, %rdx            # imm = 0x100
               	movsbq	(%rdx,%rax), %rdx
               	cmpl	%r15d, %edx
               	jne	<addr>
               	movl	$0x9, %esi
               	leaq	0x40(%rsp), %rdx
               	leaq	0x120(%rdx), %rdi
               	movsbq	(%rdi,%rax), %rdi
               	cmpl	%ecx, %edi
               	jne	<addr>
               	movl	$0xa, %esi
               	leaq	0x140(%rdx), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	nopl	(%rax)
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %esi
               	leaq	0x40(%rsp), %rcx
               	leaq	0x160(%rcx), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	nopl	(%rax,%rax)
               	cmpl	-0x10(%rbp), %edx
               	jne	<addr>
               	movl	$0xc, %esi
               	addq	$0x180, %rcx            # imm = 0x180
               	movsbq	(%rcx,%rax), %rcx
               	cmpl	-0x18(%rbp), %ecx
               	jne	<addr>
               	incq	%rax
               	nop
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
               	leaq	0x10(%rsi), %rax
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
               	vmovups	(%rdx), %ymm1
               	vpaddb	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x20(%rdx), %ymm2
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
               	leaq	0x80(%rdi), %rcx
               	leaq	0x80(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	movzbq	0x40(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x80(%rsp)
               	movzbq	0x1(%rsp), %rax
               	movzbq	0x41(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x81(%rsp)
               	movzbq	0x2(%rsp), %rax
               	movzbq	0x42(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x82(%rsp)
               	movzbq	0x3(%rsp), %rax
               	movzbq	0x43(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x83(%rsp)
               	movzbq	0x4(%rsp), %rax
               	movzbq	0x44(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x84(%rsp)
               	movzbq	0x5(%rsp), %rax
               	movzbq	0x45(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x85(%rsp)
               	movzbq	0x6(%rsp), %rax
               	movzbq	0x46(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x86(%rsp)
               	movzbq	0x7(%rsp), %rax
               	movzbq	0x47(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x87(%rsp)
               	movzbq	0x8(%rsp), %rax
               	movzbq	0x48(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x88(%rsp)
               	movzbq	0x9(%rsp), %rax
               	movzbq	0x49(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x89(%rsp)
               	movzbq	0xa(%rsp), %rax
               	movzbq	0x4a(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x8a(%rsp)
               	movzbq	0xb(%rsp), %rax
               	movzbq	0x4b(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x8b(%rsp)
               	movzbq	0xc(%rsp), %rax
               	movzbq	0x4c(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x8c(%rsp)
               	movzbq	0xd(%rsp), %rax
               	movzbq	0x4d(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x8d(%rsp)
               	movzbq	0xe(%rsp), %rax
               	movzbq	0x4e(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x8e(%rsp)
               	movzbq	0xf(%rsp), %rax
               	movzbq	0x4f(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x8f(%rsp)
               	movzbq	0x10(%rsp), %rax
               	movzbq	0x50(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x90(%rsp)
               	movzbq	0x11(%rsp), %rax
               	movzbq	0x51(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x91(%rsp)
               	movzbq	0x12(%rsp), %rax
               	movzbq	0x52(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x92(%rsp)
               	movzbq	0x13(%rsp), %rax
               	movzbq	0x53(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x93(%rsp)
               	movzbq	0x14(%rsp), %rax
               	movzbq	0x54(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x94(%rsp)
               	movzbq	0x15(%rsp), %rax
               	movzbq	0x55(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x95(%rsp)
               	movzbq	0x16(%rsp), %rax
               	movzbq	0x56(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x96(%rsp)
               	movzbq	0x17(%rsp), %rax
               	movzbq	0x57(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x97(%rsp)
               	movzbq	0x18(%rsp), %rax
               	movzbq	0x58(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x98(%rsp)
               	movzbq	0x19(%rsp), %rax
               	movzbq	0x59(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x99(%rsp)
               	movzbq	0x1a(%rsp), %rax
               	movzbq	0x5a(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x9a(%rsp)
               	movzbq	0x1b(%rsp), %rax
               	movzbq	0x5b(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x9b(%rsp)
               	movzbq	0x1c(%rsp), %rax
               	movzbq	0x5c(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x9c(%rsp)
               	movzbq	0x1d(%rsp), %rax
               	movzbq	0x5d(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x9d(%rsp)
               	movzbq	0x1e(%rsp), %rax
               	movzbq	0x5e(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x9e(%rsp)
               	movzbq	0x1f(%rsp), %rax
               	movzbq	0x5f(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x9f(%rsp)
               	movzbq	0x20(%rsp), %rax
               	movzbq	0x60(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa0(%rsp)
               	movzbq	0x21(%rsp), %rax
               	movzbq	0x61(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa1(%rsp)
               	movzbq	0x22(%rsp), %rax
               	movzbq	0x62(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa2(%rsp)
               	movzbq	0x23(%rsp), %rax
               	movzbq	0x63(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa3(%rsp)
               	movzbq	0x24(%rsp), %rax
               	movzbq	0x64(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa4(%rsp)
               	movzbq	0x25(%rsp), %rax
               	movzbq	0x65(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa5(%rsp)
               	movzbq	0x26(%rsp), %rax
               	movzbq	0x66(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa6(%rsp)
               	movzbq	0x27(%rsp), %rax
               	movzbq	0x67(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa7(%rsp)
               	movzbq	0x28(%rsp), %rax
               	movzbq	0x68(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa8(%rsp)
               	movzbq	0x29(%rsp), %rax
               	movzbq	0x69(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xa9(%rsp)
               	movzbq	0x2a(%rsp), %rax
               	movzbq	0x6a(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xaa(%rsp)
               	movzbq	0x2b(%rsp), %rax
               	movzbq	0x6b(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xab(%rsp)
               	movzbq	0x2c(%rsp), %rax
               	movzbq	0x6c(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xac(%rsp)
               	movzbq	0x2d(%rsp), %rax
               	movzbq	0x6d(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xad(%rsp)
               	movzbq	0x2e(%rsp), %rax
               	movzbq	0x6e(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xae(%rsp)
               	movzbq	0x2f(%rsp), %rax
               	movzbq	0x6f(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xaf(%rsp)
               	movzbq	0x30(%rsp), %rax
               	movzbq	0x70(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb0(%rsp)
               	movzbq	0x31(%rsp), %rax
               	movzbq	0x71(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb1(%rsp)
               	movzbq	0x32(%rsp), %rax
               	movzbq	0x72(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb2(%rsp)
               	movzbq	0x33(%rsp), %rax
               	movzbq	0x73(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb3(%rsp)
               	movzbq	0x34(%rsp), %rax
               	movzbq	0x74(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb4(%rsp)
               	movzbq	0x35(%rsp), %rax
               	movzbq	0x75(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb5(%rsp)
               	movzbq	0x36(%rsp), %rax
               	movzbq	0x76(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb6(%rsp)
               	movzbq	0x37(%rsp), %rax
               	movzbq	0x77(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb7(%rsp)
               	movzbq	0x38(%rsp), %rax
               	movzbq	0x78(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb8(%rsp)
               	movzbq	0x39(%rsp), %rax
               	movzbq	0x79(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xb9(%rsp)
               	movzbq	0x3a(%rsp), %rax
               	movzbq	0x7a(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xba(%rsp)
               	movzbq	0x3b(%rsp), %rax
               	movzbq	0x7b(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xbb(%rsp)
               	movzbq	0x3c(%rsp), %rax
               	movzbq	0x7c(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xbc(%rsp)
               	movzbq	0x3d(%rsp), %rax
               	movzbq	0x7d(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xbd(%rsp)
               	movzbq	0x3e(%rsp), %rax
               	movzbq	0x7e(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xbe(%rsp)
               	movzbq	0x3f(%rsp), %rax
               	movzbq	0x7f(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0xbf(%rsp)
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rcx)
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
               	leaq	0x200(%rdi), %rcx
               	leaq	0x80(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x80(%rsp)
               	movzbq	0x1(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x81(%rsp)
               	movzbq	0x2(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x82(%rsp)
               	movzbq	0x3(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x83(%rsp)
               	movzbq	0x4(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x84(%rsp)
               	movzbq	0x5(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x85(%rsp)
               	movzbq	0x6(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x86(%rsp)
               	movzbq	0x7(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x87(%rsp)
               	movzbq	0x8(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x88(%rsp)
               	movzbq	0x9(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x89(%rsp)
               	movzbq	0xa(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x8a(%rsp)
               	movzbq	0xb(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x8b(%rsp)
               	movzbq	0xc(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x8c(%rsp)
               	movzbq	0xd(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x8d(%rsp)
               	movzbq	0xe(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x8e(%rsp)
               	movzbq	0xf(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x8f(%rsp)
               	movzbq	0x10(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x90(%rsp)
               	movzbq	0x11(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x91(%rsp)
               	movzbq	0x12(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x92(%rsp)
               	movzbq	0x13(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x93(%rsp)
               	movzbq	0x14(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x94(%rsp)
               	movzbq	0x15(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x95(%rsp)
               	movzbq	0x16(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x96(%rsp)
               	movzbq	0x17(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x97(%rsp)
               	movzbq	0x18(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x98(%rsp)
               	movzbq	0x19(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x99(%rsp)
               	movzbq	0x1a(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x9a(%rsp)
               	movzbq	0x1b(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x9b(%rsp)
               	movzbq	0x1c(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x9c(%rsp)
               	movzbq	0x1d(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x9d(%rsp)
               	movzbq	0x1e(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x9e(%rsp)
               	movzbq	0x1f(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x9f(%rsp)
               	movzbq	0x20(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa0(%rsp)
               	movzbq	0x21(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa1(%rsp)
               	movzbq	0x22(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa2(%rsp)
               	movzbq	0x23(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa3(%rsp)
               	movzbq	0x24(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa4(%rsp)
               	movzbq	0x25(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa5(%rsp)
               	movzbq	0x26(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa6(%rsp)
               	movzbq	0x27(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa7(%rsp)
               	movzbq	0x28(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa8(%rsp)
               	movzbq	0x29(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xa9(%rsp)
               	movzbq	0x2a(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xaa(%rsp)
               	movzbq	0x2b(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xab(%rsp)
               	movzbq	0x2c(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xac(%rsp)
               	movzbq	0x2d(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xad(%rsp)
               	movzbq	0x2e(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xae(%rsp)
               	movzbq	0x2f(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xaf(%rsp)
               	movzbq	0x30(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb0(%rsp)
               	movzbq	0x31(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb1(%rsp)
               	movzbq	0x32(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb2(%rsp)
               	movzbq	0x33(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb3(%rsp)
               	movzbq	0x34(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb4(%rsp)
               	movzbq	0x35(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb5(%rsp)
               	movzbq	0x36(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb6(%rsp)
               	movzbq	0x37(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb7(%rsp)
               	movzbq	0x38(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb8(%rsp)
               	movzbq	0x39(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xb9(%rsp)
               	movzbq	0x3a(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xba(%rsp)
               	movzbq	0x3b(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xbb(%rsp)
               	movzbq	0x3c(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xbc(%rsp)
               	movzbq	0x3d(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xbd(%rsp)
               	movzbq	0x3e(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xbe(%rsp)
               	movzbq	0x3f(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0xbf(%rsp)
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rcx)
               	leaq	0x240(%rdi), %rcx
               	leaq	0x80(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x80(%rsp)
               	movzbq	0x1(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x81(%rsp)
               	movzbq	0x2(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x82(%rsp)
               	movzbq	0x3(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x83(%rsp)
               	movzbq	0x4(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x84(%rsp)
               	movzbq	0x5(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x85(%rsp)
               	movzbq	0x6(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x86(%rsp)
               	movzbq	0x7(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x87(%rsp)
               	movzbq	0x8(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x88(%rsp)
               	movzbq	0x9(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x89(%rsp)
               	movzbq	0xa(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x8a(%rsp)
               	movzbq	0xb(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x8b(%rsp)
               	movzbq	0xc(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x8c(%rsp)
               	movzbq	0xd(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x8d(%rsp)
               	movzbq	0xe(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x8e(%rsp)
               	movzbq	0xf(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x8f(%rsp)
               	movzbq	0x10(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x90(%rsp)
               	movzbq	0x11(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x91(%rsp)
               	movzbq	0x12(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x92(%rsp)
               	movzbq	0x13(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x93(%rsp)
               	movzbq	0x14(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x94(%rsp)
               	movzbq	0x15(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x95(%rsp)
               	movzbq	0x16(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x96(%rsp)
               	movzbq	0x17(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x97(%rsp)
               	movzbq	0x18(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x98(%rsp)
               	movzbq	0x19(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x99(%rsp)
               	movzbq	0x1a(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x9a(%rsp)
               	movzbq	0x1b(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x9b(%rsp)
               	movzbq	0x1c(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x9c(%rsp)
               	movzbq	0x1d(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x9d(%rsp)
               	movzbq	0x1e(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x9e(%rsp)
               	movzbq	0x1f(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0x9f(%rsp)
               	movzbq	0x20(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa0(%rsp)
               	movzbq	0x21(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa1(%rsp)
               	movzbq	0x22(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa2(%rsp)
               	movzbq	0x23(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa3(%rsp)
               	movzbq	0x24(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa4(%rsp)
               	movzbq	0x25(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa5(%rsp)
               	movzbq	0x26(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa6(%rsp)
               	movzbq	0x27(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa7(%rsp)
               	movzbq	0x28(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa8(%rsp)
               	movzbq	0x29(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xa9(%rsp)
               	movzbq	0x2a(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xaa(%rsp)
               	movzbq	0x2b(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xab(%rsp)
               	movzbq	0x2c(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xac(%rsp)
               	movzbq	0x2d(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xad(%rsp)
               	movzbq	0x2e(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xae(%rsp)
               	movzbq	0x2f(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xaf(%rsp)
               	movzbq	0x30(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb0(%rsp)
               	movzbq	0x31(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb1(%rsp)
               	movzbq	0x32(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb2(%rsp)
               	movzbq	0x33(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb3(%rsp)
               	movzbq	0x34(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb4(%rsp)
               	movzbq	0x35(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb5(%rsp)
               	movzbq	0x36(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb6(%rsp)
               	movzbq	0x37(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb7(%rsp)
               	movzbq	0x38(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb8(%rsp)
               	movzbq	0x39(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xb9(%rsp)
               	movzbq	0x3a(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xba(%rsp)
               	movzbq	0x3b(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xbb(%rsp)
               	movzbq	0x3c(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xbc(%rsp)
               	movzbq	0x3d(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xbd(%rsp)
               	movzbq	0x3e(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xbe(%rsp)
               	movzbq	0x3f(%rsp), %rax
               	shrq	$0x5, %rax
               	movb	%al, 0xbf(%rsp)
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rcx)
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
               	xorl	%ecx, %ecx
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rdi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movb	%al, 0x40(%rsp,%rcx)
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	%rdi, %rax
               	addq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rsp,%rcx)
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	nopl	(%rax)
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	%rdi, %rax
               	addq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
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
               	movq	%rcx, %r10
               	andq	%rdx, %r10
               	movq	%r10, -0x10(%rbp)
               	movq	%rcx, %r10
               	orq	%rdx, %r10
               	movq	%r10, -0x18(%rbp)
               	xorq	%rcx, %rdx
               	xorl	%r10d, %r10d
               	movq	%r10, -0x8(%rbp)
               	movq	%rcx, %r9
               	negq	%r9
               	andq	$0xff, %r9
               	movq	%rcx, %rbx
               	xorq	$-0x1, %rbx
               	andq	$0xff, %rbx
               	shlq	$0x3, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%rsp,%rax), %r12
               	shrq	$0x5, %r12
               	movzbq	(%rsp,%rax), %r13
               	movzbq	0x40(%rsp,%rax), %r14
               	cmpl	%r14d, %r13d
               	setl	%r13b
               	movzbq	%r13b, %r13
               	negq	%r13
               	andq	$0xff, %r13
               	movzbq	(%rsp,%rax), %r14
               	movzbq	0x40(%rsp,%rax), %r15
               	cmpl	%r15d, %r14d
               	setge	%r14b
               	movzbq	%r14b, %r14
               	negq	%r14
               	andq	$0xff, %r14
               	movzbq	(%rsp,%rax), %r15
               	movzbq	0x40(%rsp,%rax), %r10
               	movq	%r10, -0x20(%rbp)
               	cmpl	-0x20(%rbp), %r15d
               	sete	%r15b
               	movzbq	%r15b, %r15
               	negq	%r15
               	andq	$0xff, %r15
               	movzbq	0x80(%rsp,%rax), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpl	%r10d, %esi
               	jne	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rsi
               	addq	$0x40, %rsi
               	movzbq	(%rsi,%rax), %rsi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rsi
               	addq	$0x80, %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	$0x3, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rsi
               	addq	$0xc0, %rsi
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	-0x10(%rbp), %esi
               	jne	<addr>
               	movl	$0x4, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rsi
               	addq	$0x100, %rsi            # imm = 0x100
               	movzbq	(%rsi,%rax), %rsi
               	cmpl	-0x18(%rbp), %esi
               	jne	<addr>
               	movl	$0x5, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rsi
               	addq	$0x140, %rsi            # imm = 0x140
               	movzbq	(%rsi,%rax), %rsi
               	nopl	(%rax,%rax)
               	cmpl	%edx, %esi
               	jne	<addr>
               	movl	$0x6, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rdx
               	addq	$0x180, %rdx            # imm = 0x180
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%r9d, %edx
               	jne	<addr>
               	movl	$0x7, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rdx
               	addq	$0x1c0, %rdx            # imm = 0x1C0
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%ebx, %edx
               	jne	<addr>
               	movl	$0x8, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rdx
               	addq	$0x200, %rdx            # imm = 0x200
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movl	$0x9, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rcx
               	leaq	0x240(%rcx), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	nopl	(%rax)
               	cmpl	%r12d, %edx
               	jne	<addr>
               	movl	$0xa, %r10d
               	movq	%r10, -0x8(%rbp)
               	addq	$0x280, %rcx            # imm = 0x280
               	movzbq	(%rcx,%rax), %rcx
               	nop
               	cmpl	%r13d, %ecx
               	jne	<addr>
               	movl	$0xb, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x80(%rsp), %rcx
               	leaq	0x2c0(%rcx), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%r14d, %edx
               	jne	<addr>
               	movl	$0xc, %r10d
               	movq	%r10, -0x8(%rbp)
               	addq	$0x300, %rcx            # imm = 0x300
               	movzbq	(%rcx,%rax), %rcx
               	nop
               	cmpl	%r15d, %ecx
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
               	movq	-0x8(%rbp), %rax
               	addq	$0x20, %rax
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
               	subq	$0x28, %rsp
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
               	leaq	(%rsp), %rcx
               	vpextrw	$0x0, %xmm0, %edx
               	vpextrw	$0x0, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, (%rsp)
               	vpextrw	$0x1, %xmm0, %edx
               	vpextrw	$0x1, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x2(%rsp)
               	vpextrw	$0x2, %xmm0, %edx
               	vpextrw	$0x2, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x4(%rsp)
               	vpextrw	$0x3, %xmm0, %edx
               	vpextrw	$0x3, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x6(%rsp)
               	vpextrw	$0x4, %xmm0, %edx
               	vpextrw	$0x4, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x8(%rsp)
               	vpextrw	$0x5, %xmm0, %edx
               	vpextrw	$0x5, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xa(%rsp)
               	vpextrw	$0x6, %xmm0, %edx
               	vpextrw	$0x6, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xc(%rsp)
               	vpextrw	$0x7, %xmm0, %edx
               	vpextrw	$0x7, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xe(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x0, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x0, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x10(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x1, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x1, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x12(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x2, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x2, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x14(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x3, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x3, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x16(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x4, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x4, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x18(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x5, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x5, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x1a(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x6, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x6, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x1c(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x7, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x7, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x1e(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x160(%rdi), %rax
               	leaq	(%rsp), %rcx
               	vpextrw	$0x0, %xmm0, %edx
               	vpextrw	$0x0, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, (%rsp)
               	vpextrw	$0x1, %xmm0, %edx
               	vpextrw	$0x1, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x2(%rsp)
               	vpextrw	$0x2, %xmm0, %edx
               	vpextrw	$0x2, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x4(%rsp)
               	vpextrw	$0x3, %xmm0, %edx
               	vpextrw	$0x3, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x6(%rsp)
               	vpextrw	$0x4, %xmm0, %edx
               	vpextrw	$0x4, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x8(%rsp)
               	vpextrw	$0x5, %xmm0, %edx
               	vpextrw	$0x5, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xa(%rsp)
               	vpextrw	$0x6, %xmm0, %edx
               	vpextrw	$0x6, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xc(%rsp)
               	vpextrw	$0x7, %xmm0, %edx
               	vpextrw	$0x7, %xmm1, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0xe(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x0, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x0, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x10(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x1, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x1, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x12(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x2, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x2, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x14(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x3, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x3, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x16(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x4, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x4, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x18(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x5, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x5, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x1a(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x6, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x6, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x1c(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrw	$0x7, %xmm2, %edx
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrw	$0x7, %xmm2, %esi
               	cmpq	%rsi, %rdx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x1e(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpcmpeqw	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x180(%rdi)
               	vzeroupper
               	addq	$0x28, %rsp
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
               	xorl	%ecx, %ecx
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rdi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movw	%ax, 0x20(%rsp,%rcx,2)
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	%rdi, %rax
               	addq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, (%rsp,%rcx,2)
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	nopl	(%rax)
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	%rdi, %rax
               	addq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
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
               	movq	%rcx, %r10
               	andq	%rdx, %r10
               	movq	%r10, -0x10(%rbp)
               	movq	%rcx, %r10
               	orq	%rdx, %r10
               	movq	%r10, -0x18(%rbp)
               	xorq	%rcx, %rdx
               	xorl	%r10d, %r10d
               	movq	%r10, -0x8(%rbp)
               	movq	%rcx, %r9
               	negq	%r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movq	%rcx, %rbx
               	xorq	$-0x1, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	shlq	$0x3, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movzwq	(%rsp,%rax,2), %r12
               	shrq	$0x5, %r12
               	movzwq	(%rsp,%rax,2), %r13
               	movzwq	0x20(%rsp,%rax,2), %r14
               	cmpl	%r14d, %r13d
               	setl	%r13b
               	movzbq	%r13b, %r13
               	negq	%r13
               	andq	$0xffff, %r13           # imm = 0xFFFF
               	movzwq	(%rsp,%rax,2), %r14
               	movzwq	0x20(%rsp,%rax,2), %r15
               	cmpl	%r15d, %r14d
               	setge	%r14b
               	movzbq	%r14b, %r14
               	negq	%r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	movzwq	(%rsp,%rax,2), %r15
               	movzwq	0x20(%rsp,%rax,2), %r10
               	movq	%r10, -0x20(%rbp)
               	cmpl	-0x20(%rbp), %r15d
               	sete	%r15b
               	movzbq	%r15b, %r15
               	negq	%r15
               	andq	$0xffff, %r15           # imm = 0xFFFF
               	movzwq	0x40(%rsp,%rax,2), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpl	%r10d, %esi
               	jne	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rsi
               	addq	$0x20, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x2, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rsi
               	addq	$0x40, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	$0x3, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rsi
               	addq	$0x60, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	-0x10(%rbp), %esi
               	jne	<addr>
               	movl	$0x4, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rsi
               	addq	$0x80, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	nopl	(%rax,%rax)
               	cmpl	-0x18(%rbp), %esi
               	jne	<addr>
               	movl	$0x5, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rsi
               	addq	$0xa0, %rsi
               	movzwq	(%rsi,%rax,2), %rsi
               	cmpl	%edx, %esi
               	jne	<addr>
               	movl	$0x6, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rdx
               	addq	$0xc0, %rdx
               	movzwq	(%rdx,%rax,2), %rdx
               	cmpl	%r9d, %edx
               	jne	<addr>
               	movl	$0x7, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rdx
               	addq	$0xe0, %rdx
               	movzwq	(%rdx,%rax,2), %rdx
               	cmpl	%ebx, %edx
               	jne	<addr>
               	movl	$0x8, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rdx
               	addq	$0x100, %rdx            # imm = 0x100
               	movzwq	(%rdx,%rax,2), %rdx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movl	$0x9, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rcx
               	leaq	0x120(%rcx), %rdx
               	movzwq	(%rdx,%rax,2), %rdx
               	cmpl	%r12d, %edx
               	jne	<addr>
               	movl	$0xa, %r10d
               	movq	%r10, -0x8(%rbp)
               	addq	$0x140, %rcx            # imm = 0x140
               	movzwq	(%rcx,%rax,2), %rcx
               	cmpl	%r13d, %ecx
               	jne	<addr>
               	movl	$0xb, %r10d
               	movq	%r10, -0x8(%rbp)
               	leaq	0x40(%rsp), %rcx
               	leaq	0x160(%rcx), %rdx
               	movzwq	(%rdx,%rax,2), %rdx
               	cmpl	%r14d, %edx
               	jne	<addr>
               	movl	$0xc, %r10d
               	movq	%r10, -0x8(%rbp)
               	addq	$0x180, %rcx            # imm = 0x180
               	movzwq	(%rcx,%rax,2), %rcx
               	cmpl	%r15d, %ecx
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
               	movq	-0x8(%rbp), %rax
               	addq	$0x30, %rax
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
               	vmovups	(%rdx), %ymm1
               	vpaddw	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x20(%rdx), %ymm2
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
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rdi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movw	%cx, 0x40(%rsp,%rax,2)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x20, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movw	%cx, (%rsp,%rax,2)
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	nopw	(%rax,%rax)
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movswq	%cx, %rcx
               	jmp	<addr>
               	movswq	%cx, %rcx
               	jmp	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movswq	(%rsp,%rax,2), %rcx
               	movswq	0x40(%rsp,%rax,2), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movswq	%si, %rdi
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	movswq	%si, %r8
               	movq	%rcx, %rsi
               	imulq	%rdx, %rsi
               	movswq	%si, %r9
               	movq	%rcx, %rsi
               	andq	%rdx, %rsi
               	movswq	%si, %rbx
               	movq	%rcx, %r12
               	orq	%rdx, %r12
               	xorq	%rcx, %rdx
               	xorl	%esi, %esi
               	movq	%rcx, %r13
               	negq	%r13
               	movswq	%r13w, %r13
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	shlq	$0x3, %rcx
               	movswq	%cx, %r15
               	movswq	(%rsp,%rax,2), %rcx
               	sarq	$0x5, %rcx
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
               	nopl	(%rax,%rax)
               	movq	%rdi, %r10
               	movq	-0x20(%rbp), %rdi
               	cmpl	%r10d, %edi
               	jne	<addr>
               	movl	$0x1, %esi
               	leaq	0x80(%rsp), %rdi
               	addq	$0x40, %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	cmpl	%r8d, %edi
               	jne	<addr>
               	movl	$0x2, %esi
               	leaq	0x80(%rsp), %rdi
               	addq	$0x80, %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x3, %esi
               	leaq	0x80(%rsp), %rdi
               	addq	$0xc0, %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	cmpl	%ebx, %edi
               	jne	<addr>
               	movl	$0x4, %esi
               	leaq	0x80(%rsp), %rdi
               	addq	$0x100, %rdi            # imm = 0x100
               	movswq	(%rdi,%rax,2), %rdi
               	cmpl	%r12d, %edi
               	jne	<addr>
               	movl	$0x5, %esi
               	leaq	0x80(%rsp), %rdi
               	addq	$0x140, %rdi            # imm = 0x140
               	movswq	(%rdi,%rax,2), %rdi
               	cmpl	%edx, %edi
               	jne	<addr>
               	movl	$0x6, %esi
               	leaq	0x80(%rsp), %rdx
               	addq	$0x180, %rdx            # imm = 0x180
               	movswq	(%rdx,%rax,2), %rdx
               	cmpl	%r13d, %edx
               	jne	<addr>
               	movl	$0x7, %esi
               	leaq	0x80(%rsp), %rdx
               	addq	$0x1c0, %rdx            # imm = 0x1C0
               	movswq	(%rdx,%rax,2), %rdx
               	cmpl	%r14d, %edx
               	jne	<addr>
               	movl	$0x8, %esi
               	leaq	0x80(%rsp), %rdx
               	addq	$0x200, %rdx            # imm = 0x200
               	movswq	(%rdx,%rax,2), %rdx
               	cmpl	%r15d, %edx
               	jne	<addr>
               	movl	$0x9, %esi
               	leaq	0x80(%rsp), %rdx
               	leaq	0x240(%rdx), %rdi
               	movswq	(%rdi,%rax,2), %rdi
               	cmpl	%ecx, %edi
               	jne	<addr>
               	movl	$0xa, %esi
               	leaq	0x280(%rdx), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %esi
               	leaq	0x80(%rsp), %rcx
               	leaq	0x2c0(%rcx), %rdx
               	movswq	(%rdx,%rax,2), %rdx
               	cmpl	-0x10(%rbp), %edx
               	jne	<addr>
               	movl	$0xc, %esi
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
               	leaq	0x40(%rsi), %rax
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
               	subq	$0x28, %rsp
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpaddd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsubd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rdi)
               	leaq	0x40(%rdi), %rcx
               	leaq	(%rsp), %rdx
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%xmm1, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rax
               	movl	%eax, (%rsp)
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x1, %xmm1, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rax
               	movl	%eax, 0x4(%rsp)
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x2, %xmm1, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rax
               	movl	%eax, 0x8(%rsp)
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x3, %xmm1, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rax
               	movl	%eax, 0xc(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vmovd	%xmm2, %eax
               	movslq	%eax, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vmovd	%xmm2, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rax
               	movl	%eax, 0x10(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x1, %xmm2, %eax
               	movslq	%eax, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x1, %xmm2, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rax
               	movl	%eax, 0x14(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x2, %xmm2, %eax
               	movslq	%eax, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x2, %xmm2, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rax
               	movl	%eax, 0x18(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm2
               	vpextrd	$0x3, %xmm2, %eax
               	movslq	%eax, %rax
               	vextracti128	$0x1, %ymm1, %xmm2
               	vpextrd	$0x3, %xmm2, %esi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rax
               	movl	%eax, 0x1c(%rsp)
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
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
               	leaq	(%rsp), %rcx
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	vmovd	%xmm1, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, (%rsp)
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpextrd	$0x1, %xmm1, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x4(%rsp)
               	vpextrd	$0x2, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpextrd	$0x2, %xmm1, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x8(%rsp)
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpextrd	$0x3, %xmm1, %esi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0xc(%rsp)
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
               	movl	%edx, 0x10(%rsp)
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
               	movl	%edx, 0x14(%rsp)
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
               	movl	%edx, 0x18(%rsp)
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
               	movl	%edx, 0x1c(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vpcmpeqd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x180(%rdi)
               	vzeroupper
               	addq	$0x28, %rsp
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
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rdi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movl	%ecx, 0x20(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movl	%ecx, (%rsp,%rax,4)
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	(%rsp,%rax,4), %ecx
               	movl	0x20(%rsp,%rax,4), %edx
               	leaq	(%rcx,%rdx), %r8
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	movq	%rcx, %rbx
               	imulq	%rdx, %rbx
               	movq	%rcx, %r12
               	andq	%rdx, %r12
               	movq	%rcx, %r13
               	orq	%rdx, %r13
               	xorq	%rcx, %rdx
               	xorl	%edi, %edi
               	movq	%rcx, %r14
               	negq	%r14
               	movq	%rcx, %r15
               	xorq	$-0x1, %r15
               	shlq	$0x3, %rcx
               	movslq	(%rsp,%rax,4), %rsi
               	sarq	$0x5, %rsi
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
               	nopl	(%rax)
               	movq	%r8, %r10
               	movq	-0x20(%rbp), %r8
               	cmpl	%r10d, %r8d
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0x20, %r8
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0x40, %r8
               	movl	(%r8,%rax,4), %r8d
               	nopl	(%rax)
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0x60, %r8
               	movl	(%r8,%rax,4), %r8d
               	nopl	(%rax,%rax)
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movl	$0x4, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0x80, %r8
               	movl	(%r8,%rax,4), %r8d
               	nop
               	cmpl	%r13d, %r8d
               	jne	<addr>
               	movl	$0x5, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0xa0, %r8
               	movl	(%r8,%rax,4), %r8d
               	nop
               	cmpl	%edx, %r8d
               	jne	<addr>
               	movl	$0x6, %edi
               	leaq	0x40(%rsp), %rdx
               	addq	$0xc0, %rdx
               	movl	(%rdx,%rax,4), %edx
               	nopl	(%rax)
               	cmpl	%r14d, %edx
               	jne	<addr>
               	movl	$0x7, %edi
               	leaq	0x40(%rsp), %rdx
               	addq	$0xe0, %rdx
               	movl	(%rdx,%rax,4), %edx
               	nopl	(%rax)
               	cmpl	%r15d, %edx
               	jne	<addr>
               	movl	$0x8, %edi
               	leaq	0x40(%rsp), %rdx
               	addq	$0x100, %rdx            # imm = 0x100
               	movl	(%rdx,%rax,4), %edx
               	nopl	(%rax)
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movl	$0x9, %edi
               	leaq	0x40(%rsp), %rcx
               	leaq	0x120(%rcx), %rdx
               	movl	(%rdx,%rax,4), %edx
               	nopl	(%rax)
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	$0xa, %edi
               	addq	$0x140, %rcx            # imm = 0x140
               	movl	(%rcx,%rax,4), %ecx
               	nopw	(%rax,%rax)
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %edi
               	leaq	0x40(%rsp), %rcx
               	leaq	0x160(%rcx), %rdx
               	movl	(%rdx,%rax,4), %edx
               	nopl	(%rax)
               	cmpl	-0x10(%rbp), %edx
               	jne	<addr>
               	movl	$0xc, %edi
               	addq	$0x180, %rcx            # imm = 0x180
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	-0x18(%rbp), %ecx
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
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
               	leaq	0x50(%rdi), %rax
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
               	vmovups	(%rdx), %ymm1
               	vpaddd	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x20(%rdx), %ymm2
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
               	leaq	0x80(%rdi), %rcx
               	leaq	0x80(%rsp), %rdx
               	movl	(%rsp), %eax
               	movl	0x40(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0x80(%rsp)
               	movl	0x4(%rsp), %eax
               	movl	0x44(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0x84(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	0x48(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0x88(%rsp)
               	movl	0xc(%rsp), %eax
               	movl	0x4c(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0x8c(%rsp)
               	movl	0x10(%rsp), %eax
               	movl	0x50(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0x90(%rsp)
               	movl	0x14(%rsp), %eax
               	movl	0x54(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0x94(%rsp)
               	movl	0x18(%rsp), %eax
               	movl	0x58(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0x98(%rsp)
               	movl	0x1c(%rsp), %eax
               	movl	0x5c(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0x9c(%rsp)
               	movl	0x20(%rsp), %eax
               	movl	0x60(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0xa0(%rsp)
               	movl	0x24(%rsp), %eax
               	movl	0x64(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0xa4(%rsp)
               	movl	0x28(%rsp), %eax
               	movl	0x68(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0xa8(%rsp)
               	movl	0x2c(%rsp), %eax
               	movl	0x6c(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0xac(%rsp)
               	movl	0x30(%rsp), %eax
               	movl	0x70(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0xb0(%rsp)
               	movl	0x34(%rsp), %eax
               	movl	0x74(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0xb4(%rsp)
               	movl	0x38(%rsp), %eax
               	movl	0x78(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0xb8(%rsp)
               	movl	0x3c(%rsp), %eax
               	movl	0x7c(%rsp), %esi
               	imulq	%rsi, %rax
               	movl	%eax, 0xbc(%rsp)
               	vmovups	(%rdx), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	0x20(%rdx), %ymm14
               	vmovups	%ymm14, 0x20(%rcx)
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
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rdi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movl	%ecx, 0x40(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movl	%ecx, (%rsp,%rax,4)
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	jmp	<addr>
               	movl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	(%rsp,%rax,4), %ecx
               	movl	0x40(%rsp,%rax,4), %edx
               	leaq	(%rcx,%rdx), %r8
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	movq	%rcx, %rbx
               	imulq	%rdx, %rbx
               	movq	%rcx, %r12
               	andq	%rdx, %r12
               	movq	%rcx, %r13
               	orq	%rdx, %r13
               	xorq	%rcx, %rdx
               	xorl	%edi, %edi
               	movq	%rcx, %r14
               	negq	%r14
               	movq	%rcx, %r15
               	xorq	$-0x1, %r15
               	shlq	$0x3, %rcx
               	movl	(%rsp,%rax,4), %esi
               	shrq	$0x5, %rsi
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
               	movq	%r8, %r10
               	movq	-0x20(%rbp), %r8
               	cmpl	%r10d, %r8d
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0x40, %r8
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0x80, %r8
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%ebx, %r8d
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0xc0, %r8
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r12d, %r8d
               	jne	<addr>
               	movl	$0x4, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0x100, %r8             # imm = 0x100
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%r13d, %r8d
               	jne	<addr>
               	movl	$0x5, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0x140, %r8             # imm = 0x140
               	movl	(%r8,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	jne	<addr>
               	movl	$0x6, %edi
               	leaq	0x80(%rsp), %rdx
               	addq	$0x180, %rdx            # imm = 0x180
               	movl	(%rdx,%rax,4), %edx
               	cmpl	%r14d, %edx
               	jne	<addr>
               	movl	$0x7, %edi
               	leaq	0x80(%rsp), %rdx
               	addq	$0x1c0, %rdx            # imm = 0x1C0
               	movl	(%rdx,%rax,4), %edx
               	cmpl	%r15d, %edx
               	jne	<addr>
               	movl	$0x8, %edi
               	leaq	0x80(%rsp), %rdx
               	addq	$0x200, %rdx            # imm = 0x200
               	movl	(%rdx,%rax,4), %edx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movl	$0x9, %edi
               	leaq	0x80(%rsp), %rcx
               	leaq	0x240(%rcx), %rdx
               	movl	(%rdx,%rax,4), %edx
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	$0xa, %edi
               	addq	$0x280, %rcx            # imm = 0x280
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	-0x8(%rbp), %ecx
               	jne	<addr>
               	movl	$0xb, %edi
               	leaq	0x80(%rsp), %rcx
               	leaq	0x2c0(%rcx), %rdx
               	movl	(%rdx,%rax,4), %edx
               	nop
               	cmpl	-0x10(%rbp), %edx
               	jne	<addr>
               	movl	$0xc, %edi
               	addq	$0x300, %rcx            # imm = 0x300
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	-0x18(%rbp), %ecx
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
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
               	leaq	0x60(%rdi), %rax
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
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rdi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movq	%rcx, 0x20(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, (%rsp,%rax,8)
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	nopw	(%rax,%rax)
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	nop
               	jmp	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	(%rsp,%rax,8), %rcx
               	movq	0x20(%rsp,%rax,8), %rdx
               	leaq	(%rcx,%rdx), %r8
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	movq	%rcx, %rbx
               	imulq	%rdx, %rbx
               	movq	%rcx, %r12
               	andq	%rdx, %r12
               	movq	%rcx, %r13
               	orq	%rdx, %r13
               	xorq	%rcx, %rdx
               	xorl	%edi, %edi
               	movq	%rcx, %r14
               	negq	%r14
               	movq	%rcx, %r15
               	xorq	$-0x1, %r15
               	shlq	$0x3, %rcx
               	movq	(%rsp,%rax,8), %rsi
               	shrq	$0x5, %rsi
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
               	movq	%r8, %r10
               	movq	-0x20(%rbp), %r8
               	cmpq	%r10, %r8
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0x20, %r8
               	movq	(%r8,%rax,8), %r8
               	cmpq	%r9, %r8
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0x40, %r8
               	movq	(%r8,%rax,8), %r8
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0x60, %r8
               	movq	(%r8,%rax,8), %r8
               	cmpq	%r12, %r8
               	jne	<addr>
               	movl	$0x4, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0x80, %r8
               	movq	(%r8,%rax,8), %r8
               	nop
               	cmpq	%r13, %r8
               	jne	<addr>
               	movl	$0x5, %edi
               	leaq	0x40(%rsp), %r8
               	addq	$0xa0, %r8
               	movq	(%r8,%rax,8), %r8
               	nop
               	cmpq	%rdx, %r8
               	jne	<addr>
               	movl	$0x6, %edi
               	leaq	0x40(%rsp), %rdx
               	addq	$0xc0, %rdx
               	movq	(%rdx,%rax,8), %rdx
               	nop
               	cmpq	%r14, %rdx
               	jne	<addr>
               	movl	$0x7, %edi
               	leaq	0x40(%rsp), %rdx
               	addq	$0xe0, %rdx
               	movq	(%rdx,%rax,8), %rdx
               	nop
               	cmpq	%r15, %rdx
               	jne	<addr>
               	movl	$0x8, %edi
               	leaq	0x40(%rsp), %rdx
               	addq	$0x100, %rdx            # imm = 0x100
               	movq	(%rdx,%rax,8), %rdx
               	nop
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movl	$0x9, %edi
               	leaq	0x40(%rsp), %rcx
               	leaq	0x120(%rcx), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	nop
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movl	$0xa, %edi
               	addq	$0x140, %rcx            # imm = 0x140
               	movq	(%rcx,%rax,8), %rcx
               	nopl	(%rax)
               	cmpq	-0x8(%rbp), %rcx
               	jne	<addr>
               	movl	$0xb, %edi
               	leaq	0x40(%rsp), %rcx
               	leaq	0x160(%rcx), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	nopl	(%rax,%rax)
               	cmpq	-0x10(%rbp), %rdx
               	jne	<addr>
               	movl	$0xc, %edi
               	addq	$0x180, %rcx            # imm = 0x180
               	movq	(%rcx,%rax,8), %rcx
               	nopw	%cs:(%rax,%rax)
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
               	leaq	0x70(%rdi), %rax
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
               	vmovups	(%rdx), %ymm1
               	vpaddq	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x20(%rdx), %ymm2
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
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rdi # imm = 0x5851F42D4C957F2D
               	jmp	<addr>
               	movq	%rcx, 0x40(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, (%rsp,%rax,8)
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	nopw	(%rax,%rax)
               	testq	%r9, %r9
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	nop
               	jmp	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	(%rsp,%rax,8), %rcx
               	movq	0x40(%rsp,%rax,8), %rdx
               	leaq	(%rcx,%rdx), %r8
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	movq	%rcx, %rbx
               	imulq	%rdx, %rbx
               	movq	%rcx, %r12
               	andq	%rdx, %r12
               	movq	%rcx, %r13
               	orq	%rdx, %r13
               	xorq	%rcx, %rdx
               	xorl	%edi, %edi
               	movq	%rcx, %r14
               	negq	%r14
               	movq	%rcx, %r15
               	xorq	$-0x1, %r15
               	shlq	$0x3, %rcx
               	movq	(%rsp,%rax,8), %rsi
               	sarq	$0x5, %rsi
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
               	movq	%r8, %r10
               	movq	-0x20(%rbp), %r8
               	cmpq	%r10, %r8
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0x40, %r8
               	movq	(%r8,%rax,8), %r8
               	cmpq	%r9, %r8
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0x80, %r8
               	movq	(%r8,%rax,8), %r8
               	cmpq	%rbx, %r8
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0xc0, %r8
               	movq	(%r8,%rax,8), %r8
               	cmpq	%r12, %r8
               	jne	<addr>
               	movl	$0x4, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0x100, %r8             # imm = 0x100
               	movq	(%r8,%rax,8), %r8
               	cmpq	%r13, %r8
               	jne	<addr>
               	movl	$0x5, %edi
               	leaq	0x80(%rsp), %r8
               	addq	$0x140, %r8             # imm = 0x140
               	movq	(%r8,%rax,8), %r8
               	nopw	(%rax,%rax)
               	cmpq	%rdx, %r8
               	jne	<addr>
               	movl	$0x6, %edi
               	leaq	0x80(%rsp), %rdx
               	addq	$0x180, %rdx            # imm = 0x180
               	movq	(%rdx,%rax,8), %rdx
               	cmpq	%r14, %rdx
               	jne	<addr>
               	movl	$0x7, %edi
               	leaq	0x80(%rsp), %rdx
               	addq	$0x1c0, %rdx            # imm = 0x1C0
               	movq	(%rdx,%rax,8), %rdx
               	cmpq	%r15, %rdx
               	jne	<addr>
               	movl	$0x8, %edi
               	leaq	0x80(%rsp), %rdx
               	addq	$0x200, %rdx            # imm = 0x200
               	movq	(%rdx,%rax,8), %rdx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movl	$0x9, %edi
               	leaq	0x80(%rsp), %rcx
               	leaq	0x240(%rcx), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movl	$0xa, %edi
               	addq	$0x280, %rcx            # imm = 0x280
               	movq	(%rcx,%rax,8), %rcx
               	nopl	(%rax)
               	cmpq	-0x8(%rbp), %rcx
               	jne	<addr>
               	movl	$0xb, %edi
               	leaq	0x80(%rsp), %rcx
               	leaq	0x2c0(%rcx), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	nop
               	cmpq	-0x10(%rbp), %rdx
               	jne	<addr>
               	movl	$0xc, %edi
               	addq	$0x300, %rcx            # imm = 0x300
               	movq	(%rcx,%rax,8), %rcx
               	nopw	%cs:(%rax,%rax)
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
               	leaq	0x80(%rdi), %rax
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
               	subq	$0x28, %rsp
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
               	leaq	(%rsp), %rcx
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	vxorpd	<rip>, %xmm1, %xmm1
               	movss	%xmm1, (%rsp)
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	vxorpd	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x4(%rsp)
               	vpermilps	$0x2, %xmm0, %xmm1 # xmm1 = xmm0[2,0,0,0]
               	vxorpd	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x8(%rsp)
               	vpermilps	$0x3, %xmm0, %xmm1 # xmm1 = xmm0[3,0,0,0]
               	vxorpd	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0xc(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm1
               	vxorpd	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x10(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpermilps	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0,0,0]
               	vxorpd	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x14(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpermilps	$0x2, %xmm1, %xmm1 # xmm1 = xmm1[2,0,0,0]
               	vxorpd	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x18(%rsp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x1c(%rsp)
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vzeroupper
               	addq	$0x28, %rsp
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
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	addq	%rax, %rsi
               	movq	%rsi, <rip> # <addr>
               	shrq	$0xb, %rsi
               	movabsq	$0x20c06a7159f065, %rcx # imm = 0x20C06A7159F065
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rsi
               	leaq	-0x3e8(%rsi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movabsq	$0x4189374bc6a7f0, %rsi # imm = 0x4189374BC6A7F0
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x4(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0xc(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x34(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x1c(%rsp)
               	leaq	0x20(%rsp), %r8
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x3c(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rbx
               	movq	%rbx, %rsi
               	movq	%r8, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movss	(%rsp,%rax,4), %xmm1
               	leaq	0x20(%rsp), %rcx
               	movss	0x20(%rsp,%rax,4), %xmm0
               	vaddss	%xmm0, %xmm1, %xmm2
               	leaq	(%rsp), %rcx
               	movss	(%rsp,%rax,4), %xmm1
               	vsubss	%xmm0, %xmm1, %xmm3
               	vmulss	%xmm0, %xmm1, %xmm4
               	divss	%xmm0, %xmm1
               	leaq	(%rsp), %rcx
               	movss	(%rsp,%rax,4), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	xorl	%esi, %esi
               	leaq	0x40(%rsp), %rcx
               	movss	0x40(%rsp,%rax,4), %xmm5
               	nopw	%cs:(%rax,%rax)
               	nopl	(%rax)
               	ucomiss	%xmm2, %xmm5
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %esi
               	leaq	0x20(%rcx), %rdx
               	movss	(%rdx,%rax,4), %xmm2
               	nopl	(%rax)
               	ucomiss	%xmm3, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %esi
               	leaq	0x40(%rcx), %rdx
               	movss	(%rdx,%rax,4), %xmm2
               	nopl	(%rax)
               	ucomiss	%xmm4, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %esi
               	leaq	0x60(%rcx), %rdx
               	movss	(%rdx,%rax,4), %xmm2
               	nopw	%cs:(%rax,%rax)
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %esi
               	addq	$0x80, %rcx
               	movss	(%rcx,%rax,4), %xmm1
               	nopl	(%rax,%rax)
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
               	leaq	0x90(%rsi), %rax
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
               	vmovups	(%rdx), %ymm1
               	vaddps	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x20(%rdx), %ymm2
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
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x40(%rsp)
               	movss	0x4(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x44(%rsp)
               	movss	0x8(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movss	0xc(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x4c(%rsp)
               	movss	0x10(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x50(%rsp)
               	movss	0x14(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x54(%rsp)
               	movss	0x18(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x58(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x5c(%rsp)
               	movss	0x20(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x60(%rsp)
               	movss	0x24(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x64(%rsp)
               	movss	0x28(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x68(%rsp)
               	movss	0x2c(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x6c(%rsp)
               	movss	0x30(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x70(%rsp)
               	movss	0x34(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x74(%rsp)
               	movss	0x38(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x78(%rsp)
               	movss	0x3c(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
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
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	addq	%rax, %rsi
               	movq	%rsi, <rip> # <addr>
               	shrq	$0xb, %rsi
               	movabsq	$0x20c06a7159f065, %rcx # imm = 0x20C06A7159F065
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rsi
               	leaq	-0x3e8(%rsi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movabsq	$0x4189374bc6a7f0, %rsi # imm = 0x4189374BC6A7F0
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x40(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x4(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x44(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x48(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0xc(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x4c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x50(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x54(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x58(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x1c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x5c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x60(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x64(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x68(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x6c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x70(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x34(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x74(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm1
               	addss	%xmm1, %xmm1
               	vdivss	<rip>, %xmm1, %xmm1
               	movss	%xmm1, 0x78(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x3c(%rsp)
               	leaq	0x40(%rsp), %r8
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
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
               	vdivss	<rip>, %xmm0, %xmm1
               	movss	%xmm1, 0x7c(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rbx
               	movq	%rbx, %rsi
               	movq	%r8, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movss	(%rsp,%rax,4), %xmm1
               	leaq	0x40(%rsp), %rcx
               	movss	0x40(%rsp,%rax,4), %xmm0
               	vaddss	%xmm0, %xmm1, %xmm2
               	leaq	(%rsp), %rcx
               	movss	(%rsp,%rax,4), %xmm1
               	vsubss	%xmm0, %xmm1, %xmm3
               	vmulss	%xmm0, %xmm1, %xmm4
               	divss	%xmm0, %xmm1
               	leaq	(%rsp), %rcx
               	movss	(%rsp,%rax,4), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	xorl	%esi, %esi
               	leaq	0x80(%rsp), %rcx
               	movss	0x80(%rsp,%rax,4), %xmm5
               	ucomiss	%xmm2, %xmm5
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %esi
               	leaq	0x40(%rcx), %rdx
               	movss	(%rdx,%rax,4), %xmm2
               	nop
               	ucomiss	%xmm3, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %esi
               	leaq	0x80(%rcx), %rdx
               	movss	(%rdx,%rax,4), %xmm2
               	ucomiss	%xmm4, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %esi
               	leaq	0xc0(%rcx), %rdx
               	movss	(%rdx,%rax,4), %xmm2
               	nopl	(%rax,%rax)
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %esi
               	addq	$0x100, %rcx            # imm = 0x100
               	movss	(%rcx,%rax,4), %xmm1
               	nopl	(%rax,%rax)
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
               	leaq	0xa0(%rsi), %rax
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
               	vxorpd	<rip>, %xmm1, %xmm1
               	vpermilpd	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0]
               	vxorpd	<rip>, %xmm2, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	vxorpd	<rip>, %xmm3, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	vxorpd	<rip>, %xmm0, %xmm0
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
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movabsq	$0x20c06a7159f065, %rsi # imm = 0x20C06A7159F065
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rcx
               	leaq	-0x3e8(%rcx), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movabsq	$0x4189374bc6a7f0, %rdi # imm = 0x4189374BC6A7F0
               	movq	%rcx, %rax
               	mulq	%rdi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rcx
               	leaq	0x1(%rcx), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm1
               	addsd	%xmm1, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rcx
               	leaq	-0x3e8(%rcx), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rdi
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
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rcx
               	leaq	-0x3e8(%rcx), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rdi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rcx
               	leaq	0x1(%rcx), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm1
               	addsd	%xmm1, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rcx
               	leaq	-0x3e8(%rcx), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x18(%rsp)
               	leaq	0x20(%rsp), %rsi
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, %rax
               	mulq	%rdi
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
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x38(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rbx
               	movq	%rsi, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	xorl	%eax, %eax
               	vmovq	(%rsp,%rax,8), %xmm1
               	vmovq	0x20(%rsp,%rax,8), %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm2
               	vmovq	(%rsp,%rax,8), %xmm1
               	vsubsd	%xmm0, %xmm1, %xmm3
               	vmulsd	%xmm0, %xmm1, %xmm4
               	divsd	%xmm0, %xmm1
               	vmovq	(%rsp,%rax,8), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	xorl	%esi, %esi
               	leaq	0x40(%rsp), %rcx
               	vmovq	0x40(%rsp,%rax,8), %xmm5
               	ucomisd	%xmm2, %xmm5
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %esi
               	leaq	0x20(%rcx), %rdx
               	vmovq	(%rdx,%rax,8), %xmm2
               	nop
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %esi
               	leaq	0x40(%rcx), %rdx
               	vmovq	(%rdx,%rax,8), %xmm2
               	nop
               	ucomisd	%xmm4, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %esi
               	leaq	0x60(%rcx), %rdx
               	vmovq	(%rdx,%rax,8), %xmm2
               	nopw	%cs:(%rax,%rax)
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %esi
               	addq	$0x80, %rcx
               	vmovq	(%rcx,%rax,8), %xmm1
               	nopl	(%rax)
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
               	leaq	0xb0(%rsi), %rax
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
               	vmovups	(%rdx), %ymm1
               	vaddpd	%ymm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vmovups	0x20(%rdx), %ymm2
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
               	vxorpd	<rip>, %xmm0, %xmm0
               	movsd	0x8(%rsp), %xmm1
               	vxorpd	<rip>, %xmm1, %xmm1
               	movsd	0x10(%rsp), %xmm2
               	vxorpd	<rip>, %xmm2, %xmm2
               	movsd	0x18(%rsp), %xmm3
               	vxorpd	<rip>, %xmm3, %xmm3
               	movsd	0x20(%rsp), %xmm4
               	vxorpd	<rip>, %xmm4, %xmm4
               	movsd	0x28(%rsp), %xmm5
               	vxorpd	<rip>, %xmm5, %xmm5
               	movsd	0x30(%rsp), %xmm6
               	vxorpd	<rip>, %xmm6, %xmm6
               	movsd	0x38(%rsp), %xmm7
               	vxorpd	<rip>, %xmm7, %xmm7
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
               	movabsq	$0x14057b7ef767814f, %rsi # imm = 0x14057B7EF767814F
               	addq	%rax, %rsi
               	movq	%rsi, <rip> # <addr>
               	shrq	$0xb, %rsi
               	movabsq	$0x20c06a7159f065, %rcx # imm = 0x20C06A7159F065
               	movq	%rsi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rsi
               	leaq	-0x3e8(%rsi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movabsq	$0x4189374bc6a7f0, %rsi # imm = 0x4189374BC6A7F0
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm1
               	addsd	%xmm1, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x40(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x48(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm1
               	addsd	%xmm1, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x50(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x58(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm1
               	addsd	%xmm1, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x60(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
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
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x68(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rsi
               	imulq	$0x3e8, %rdx, %rax      # imm = 0x3E8
               	subq	%rax, %rdi
               	leaq	0x1(%rdi), %rax
               	xorps	%xmm1, %xmm1
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm1
               	addsd	%xmm1, %xmm1
               	vdivsd	<rip>, %xmm1, %xmm1
               	movsd	%xmm1, 0x70(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rdi # imm = 0x14057B7EF767814F
               	addq	%rax, %rdi
               	movq	%rdi, <rip> # <addr>
               	shrq	$0xb, %rdi
               	movq	%rdi, %rax
               	mulq	%rcx
               	imulq	$0x7d1, %rdx, %rax      # imm = 0x7D1
               	subq	%rax, %rdi
               	leaq	-0x3e8(%rdi), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x38(%rsp)
               	leaq	0x40(%rsp), %r8
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
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
               	vdivsd	<rip>, %xmm0, %xmm1
               	movsd	%xmm1, 0x78(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	(%rsp), %rbx
               	movq	%rbx, %rsi
               	movq	%r8, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	vmovq	(%rsp,%rax,8), %xmm1
               	vmovq	0x40(%rsp,%rax,8), %xmm0
               	vaddsd	%xmm0, %xmm1, %xmm2
               	vmovq	(%rsp,%rax,8), %xmm1
               	vsubsd	%xmm0, %xmm1, %xmm3
               	vmulsd	%xmm0, %xmm1, %xmm4
               	divsd	%xmm0, %xmm1
               	vmovq	(%rsp,%rax,8), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	xorl	%esi, %esi
               	leaq	0x80(%rsp), %rcx
               	vmovq	0x80(%rsp,%rax,8), %xmm5
               	ucomisd	%xmm2, %xmm5
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %esi
               	leaq	0x40(%rcx), %rdx
               	vmovq	(%rdx,%rax,8), %xmm2
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %esi
               	leaq	0x80(%rcx), %rdx
               	vmovq	(%rdx,%rax,8), %xmm2
               	ucomisd	%xmm4, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %esi
               	leaq	0xc0(%rcx), %rdx
               	vmovq	(%rdx,%rax,8), %xmm2
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x4, %esi
               	addq	$0x100, %rcx            # imm = 0x100
               	vmovq	(%rcx,%rax,8), %xmm1
               	nop
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
               	leaq	0xc0(%rsi), %rax
               	incq	%rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%r11
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
               	popq	%r11
               	retq
