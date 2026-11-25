
vector_shifts_by_a_vector_of_counts.x64:	file format elf64-x86-64

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

<shifts_s8x16>:
               	subq	$0x18, %rsp
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	leaq	(%rsp), %rax
               	vpextrb	$0x0, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x0, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, (%rsp)
               	vpextrb	$0x1, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x1, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x1(%rsp)
               	vpextrb	$0x2, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x2, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x2(%rsp)
               	vpextrb	$0x3, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x3, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x3(%rsp)
               	vpextrb	$0x4, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x4, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x4(%rsp)
               	vpextrb	$0x5, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x5, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x5(%rsp)
               	vpextrb	$0x6, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x6, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x6(%rsp)
               	vpextrb	$0x7, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x7, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x7(%rsp)
               	vpextrb	$0x8, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x8, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x8(%rsp)
               	vpextrb	$0x9, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x9, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x9(%rsp)
               	vpextrb	$0xa, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xa, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xa(%rsp)
               	vpextrb	$0xb, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xb, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xb(%rsp)
               	vpextrb	$0xc, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xc, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xc(%rsp)
               	vpextrb	$0xd, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xd, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xd(%rsp)
               	vpextrb	$0xe, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xe, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xe(%rsp)
               	vpextrb	$0xf, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xf, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xf(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x10(%rdi), %rax
               	leaq	(%rsp), %rcx
               	vpextrb	$0x0, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x0, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, (%rsp)
               	vpextrb	$0x1, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x1, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x1(%rsp)
               	vpextrb	$0x2, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x2, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x2(%rsp)
               	vpextrb	$0x3, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x3, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x3(%rsp)
               	vpextrb	$0x4, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x4, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4(%rsp)
               	vpextrb	$0x5, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x5, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x5(%rsp)
               	vpextrb	$0x6, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x6, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x6(%rsp)
               	vpextrb	$0x7, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x7, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x7(%rsp)
               	vpextrb	$0x8, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x8, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x8(%rsp)
               	vpextrb	$0x9, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x9, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x9(%rsp)
               	vpextrb	$0xa, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xa, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xa(%rsp)
               	vpextrb	$0xb, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xb, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xb(%rsp)
               	vpextrb	$0xc, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xc, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xc(%rsp)
               	vpextrb	$0xd, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xd, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xd(%rsp)
               	vpextrb	$0xe, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xe, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xe(%rsp)
               	vpextrb	$0xf, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xf, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xf(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x18, %rsp
               	retq

<check_s8x16>:
               	subq	$0x50, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x11(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x21(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x12(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x22(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x13(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x23(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x15(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x25(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x16(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x26(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x17(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x27(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x19(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x29(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x1a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x1b(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2b(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x1c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x1d(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2d(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x1e(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2e(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, 0x1f(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2f(%rsp)
               	leaq	0x30(%rsp), %rdi
               	leaq	0x10(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	0x10(%rsp,%rax), %rcx
               	movsbq	0x20(%rsp,%rax), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	movsbq	%sil, %rsi
               	sarxq	%rdx, %rcx, %rcx
               	movsbq	%cl, %rdx
               	leaq	0x30(%rsp), %rcx
               	movsbq	0x30(%rsp,%rax), %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x10, %rcx
               	movsbq	(%rcx,%rax), %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq

<shifts_u8x16>:
               	subq	$0x18, %rsp
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	leaq	(%rsp), %rax
               	vpextrb	$0x0, %xmm0, %ecx
               	vpextrb	$0x0, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, (%rsp)
               	vpextrb	$0x1, %xmm0, %ecx
               	vpextrb	$0x1, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x1(%rsp)
               	vpextrb	$0x2, %xmm0, %ecx
               	vpextrb	$0x2, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x2(%rsp)
               	vpextrb	$0x3, %xmm0, %ecx
               	vpextrb	$0x3, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x3(%rsp)
               	vpextrb	$0x4, %xmm0, %ecx
               	vpextrb	$0x4, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x4(%rsp)
               	vpextrb	$0x5, %xmm0, %ecx
               	vpextrb	$0x5, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x5(%rsp)
               	vpextrb	$0x6, %xmm0, %ecx
               	vpextrb	$0x6, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x6(%rsp)
               	vpextrb	$0x7, %xmm0, %ecx
               	vpextrb	$0x7, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x7(%rsp)
               	vpextrb	$0x8, %xmm0, %ecx
               	vpextrb	$0x8, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x8(%rsp)
               	vpextrb	$0x9, %xmm0, %ecx
               	vpextrb	$0x9, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0x9(%rsp)
               	vpextrb	$0xa, %xmm0, %ecx
               	vpextrb	$0xa, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xa(%rsp)
               	vpextrb	$0xb, %xmm0, %ecx
               	vpextrb	$0xb, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xb(%rsp)
               	vpextrb	$0xc, %xmm0, %ecx
               	vpextrb	$0xc, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xc(%rsp)
               	vpextrb	$0xd, %xmm0, %ecx
               	vpextrb	$0xd, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xd(%rsp)
               	vpextrb	$0xe, %xmm0, %ecx
               	vpextrb	$0xe, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xe(%rsp)
               	vpextrb	$0xf, %xmm0, %ecx
               	vpextrb	$0xf, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, 0xf(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x10(%rdi), %rax
               	leaq	(%rsp), %rcx
               	vpextrb	$0x0, %xmm0, %edx
               	vpextrb	$0x0, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, (%rsp)
               	vpextrb	$0x1, %xmm0, %edx
               	vpextrb	$0x1, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x1(%rsp)
               	vpextrb	$0x2, %xmm0, %edx
               	vpextrb	$0x2, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x2(%rsp)
               	vpextrb	$0x3, %xmm0, %edx
               	vpextrb	$0x3, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x3(%rsp)
               	vpextrb	$0x4, %xmm0, %edx
               	vpextrb	$0x4, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4(%rsp)
               	vpextrb	$0x5, %xmm0, %edx
               	vpextrb	$0x5, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x5(%rsp)
               	vpextrb	$0x6, %xmm0, %edx
               	vpextrb	$0x6, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x6(%rsp)
               	vpextrb	$0x7, %xmm0, %edx
               	vpextrb	$0x7, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x7(%rsp)
               	vpextrb	$0x8, %xmm0, %edx
               	vpextrb	$0x8, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x8(%rsp)
               	vpextrb	$0x9, %xmm0, %edx
               	vpextrb	$0x9, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x9(%rsp)
               	vpextrb	$0xa, %xmm0, %edx
               	vpextrb	$0xa, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xa(%rsp)
               	vpextrb	$0xb, %xmm0, %edx
               	vpextrb	$0xb, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xb(%rsp)
               	vpextrb	$0xc, %xmm0, %edx
               	vpextrb	$0xc, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xc(%rsp)
               	vpextrb	$0xd, %xmm0, %edx
               	vpextrb	$0xd, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xd(%rsp)
               	vpextrb	$0xe, %xmm0, %edx
               	vpextrb	$0xe, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xe(%rsp)
               	vpextrb	$0xf, %xmm0, %edx
               	vpextrb	$0xf, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0xf(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x18, %rsp
               	retq

<check_u8x16>:
               	subq	$0x50, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x11(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x21(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x12(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x22(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x13(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x23(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x15(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x25(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x16(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x26(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x17(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x27(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x19(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x29(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x1a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x1b(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2b(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x1c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x1d(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2d(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x1e(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2e(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x1f(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, 0x2f(%rsp)
               	leaq	0x30(%rsp), %rdi
               	leaq	0x10(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movzbq	0x10(%rsp,%rax), %rcx
               	movzbq	0x20(%rsp,%rax), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	andq	$0xff, %rsi
               	shrxq	%rdx, %rcx, %rcx
               	andq	$0xff, %rcx
               	leaq	0x30(%rsp), %rdx
               	movzbq	0x30(%rsp,%rax), %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x10, %rdx
               	movzbq	(%rdx,%rax), %rdx
               	nopl	(%rax)
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq

<shifts_s16x8>:
               	pushq	%rbx
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	vpextrw	$0x0, %xmm0, %eax
               	movswq	%ax, %rax
               	vpextrw	$0x0, %xmm1, %ecx
               	movswq	%cx, %rcx
               	shlxq	%rcx, %rax, %rax
               	vpextrw	$0x1, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x1, %xmm1, %edx
               	movswq	%dx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	vpextrw	$0x2, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x2, %xmm1, %esi
               	movswq	%si, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	vpextrw	$0x3, %xmm0, %esi
               	movswq	%si, %rsi
               	vpextrw	$0x3, %xmm1, %r8d
               	movswq	%r8w, %r8
               	shlxq	%r8, %rsi, %rsi
               	vpextrw	$0x4, %xmm0, %r8d
               	movswq	%r8w, %r8
               	vpextrw	$0x4, %xmm1, %r9d
               	movswq	%r9w, %r9
               	shlxq	%r9, %r8, %r8
               	vpextrw	$0x5, %xmm0, %r9d
               	movswq	%r9w, %r9
               	vpextrw	$0x5, %xmm1, %r10d
               	movswq	%r10w, %r10
               	shlxq	%r10, %r9, %r9
               	vpextrw	$0x6, %xmm0, %r10d
               	movswq	%r10w, %r10
               	vpextrw	$0x6, %xmm1, %r11d
               	movswq	%r11w, %r11
               	shlxq	%r11, %r10, %r10
               	vpextrw	$0x7, %xmm0, %r11d
               	movswq	%r11w, %r11
               	vpextrw	$0x7, %xmm1, %ebx
               	movswq	%bx, %rbx
               	shlxq	%rbx, %r11, %r11
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, (%rdi)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x2(%rdi)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x4(%rdi)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x6(%rdi)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x8(%rdi)
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0xa(%rdi)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0xc(%rdi)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0xe(%rdi)
               	vpextrw	$0x0, %xmm0, %eax
               	movswq	%ax, %rax
               	vpextrw	$0x0, %xmm1, %ecx
               	movswq	%cx, %rcx
               	sarxq	%rcx, %rax, %rax
               	vpextrw	$0x1, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x1, %xmm1, %edx
               	movswq	%dx, %rdx
               	sarxq	%rdx, %rcx, %rcx
               	vpextrw	$0x2, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x2, %xmm1, %esi
               	movswq	%si, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	vpextrw	$0x3, %xmm0, %esi
               	movswq	%si, %rsi
               	vpextrw	$0x3, %xmm1, %r8d
               	movswq	%r8w, %r8
               	sarxq	%r8, %rsi, %rsi
               	vpextrw	$0x4, %xmm0, %r8d
               	movswq	%r8w, %r8
               	vpextrw	$0x4, %xmm1, %r9d
               	movswq	%r9w, %r9
               	sarxq	%r9, %r8, %r8
               	vpextrw	$0x5, %xmm0, %r9d
               	movswq	%r9w, %r9
               	vpextrw	$0x5, %xmm1, %r10d
               	movswq	%r10w, %r10
               	sarxq	%r10, %r9, %r9
               	vpextrw	$0x6, %xmm0, %r10d
               	movswq	%r10w, %r10
               	vpextrw	$0x6, %xmm1, %r11d
               	movswq	%r11w, %r11
               	sarxq	%r11, %r10, %r10
               	vpextrw	$0x7, %xmm0, %r11d
               	movswq	%r11w, %r11
               	vpextrw	$0x7, %xmm1, %ebx
               	movswq	%bx, %rbx
               	sarxq	%rbx, %r11, %r11
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x10(%rdi)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x12(%rdi)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x14(%rdi)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x16(%rdi)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x18(%rdi)
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x1a(%rdi)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x1c(%rdi)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x1e(%rdi)
               	popq	%rbx
               	retq

<check_s16x8>:
               	subq	$0x50, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, 0x12(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x22(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, 0x16(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x26(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, 0x1a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x2a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, 0x1c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, 0x1e(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x2e(%rsp)
               	leaq	0x30(%rsp), %rdi
               	leaq	0x10(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movswq	0x10(%rsp,%rax,2), %rcx
               	movswq	0x20(%rsp,%rax,2), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	movswq	%si, %rsi
               	sarxq	%rdx, %rcx, %rcx
               	movswq	%cx, %rdx
               	leaq	0x30(%rsp), %rcx
               	movswq	0x30(%rsp,%rax,2), %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x10, %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq

<shifts_u16x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rax
               	movzwq	(%rsp), %rcx
               	movzwq	(%rdx), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x40(%rsp)
               	movzwq	0x2(%rsp), %rcx
               	movzwq	0x22(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x42(%rsp)
               	movzwq	0x4(%rsp), %rcx
               	movzwq	0x24(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x44(%rsp)
               	movzwq	0x6(%rsp), %rcx
               	movzwq	0x26(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x46(%rsp)
               	movzwq	0x8(%rsp), %rcx
               	movzwq	0x28(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x48(%rsp)
               	movzwq	0xa(%rsp), %rcx
               	movzwq	0x2a(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x4a(%rsp)
               	movzwq	0xc(%rsp), %rcx
               	movzwq	0x2c(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x4c(%rsp)
               	movzwq	0xe(%rsp), %rcx
               	movzwq	0x2e(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x4e(%rsp)
               	movzwq	0x10(%rsp), %rcx
               	movzwq	0x30(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x50(%rsp)
               	movzwq	0x12(%rsp), %rcx
               	movzwq	0x32(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x52(%rsp)
               	movzwq	0x14(%rsp), %rcx
               	movzwq	0x34(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x54(%rsp)
               	movzwq	0x16(%rsp), %rcx
               	movzwq	0x36(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x56(%rsp)
               	movzwq	0x18(%rsp), %rcx
               	movzwq	0x38(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x58(%rsp)
               	movzwq	0x1a(%rsp), %rcx
               	movzwq	0x3a(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x5a(%rsp)
               	movzwq	0x1c(%rsp), %rcx
               	movzwq	0x3c(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x5c(%rsp)
               	movzwq	0x1e(%rsp), %rcx
               	movzwq	0x3e(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x5e(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x20(%rdi), %rax
               	leaq	0x40(%rsp), %rcx
               	movzwq	(%rsp), %rdx
               	movzwq	0x20(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x40(%rsp)
               	movzwq	0x2(%rsp), %rdx
               	movzwq	0x22(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x42(%rsp)
               	movzwq	0x4(%rsp), %rdx
               	movzwq	0x24(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x44(%rsp)
               	movzwq	0x6(%rsp), %rdx
               	movzwq	0x26(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x46(%rsp)
               	movzwq	0x8(%rsp), %rdx
               	movzwq	0x28(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x48(%rsp)
               	movzwq	0xa(%rsp), %rdx
               	movzwq	0x2a(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x4a(%rsp)
               	movzwq	0xc(%rsp), %rdx
               	movzwq	0x2c(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x4c(%rsp)
               	movzwq	0xe(%rsp), %rdx
               	movzwq	0x2e(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x4e(%rsp)
               	movzwq	0x10(%rsp), %rdx
               	movzwq	0x30(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x50(%rsp)
               	movzwq	0x12(%rsp), %rdx
               	movzwq	0x32(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x52(%rsp)
               	movzwq	0x14(%rsp), %rdx
               	movzwq	0x34(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x54(%rsp)
               	movzwq	0x16(%rsp), %rdx
               	movzwq	0x36(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x56(%rsp)
               	movzwq	0x18(%rsp), %rdx
               	movzwq	0x38(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x58(%rsp)
               	movzwq	0x1a(%rsp), %rdx
               	movzwq	0x3a(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x5a(%rsp)
               	movzwq	0x1c(%rsp), %rdx
               	movzwq	0x3c(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x5c(%rsp)
               	movzwq	0x1e(%rsp), %rdx
               	movzwq	0x3e(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x5e(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<check_u16x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x2(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x22(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x4(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x6(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x26(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0xa(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x2a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0xc(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0xe(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x2e(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x12(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x32(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x34(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x16(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x36(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x1a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x3a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x1c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x3c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x1e(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x3e(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movzwq	(%rsp,%rax,2), %rcx
               	movzwq	0x20(%rsp,%rax,2), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	shrxq	%rdx, %rcx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	leaq	0x40(%rsp), %rdx
               	movzwq	0x40(%rsp,%rax,2), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x20, %rdx
               	movzwq	(%rdx,%rax,2), %rdx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rbx
               	nopl	(%rax)
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<shifts_s32x8>:
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpsllvd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsravd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x20(%rdi)
               	vzeroupper
               	retq

<check_s32x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x4(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0xc(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x34(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x1c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x3c(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movslq	(%rsp,%rax,4), %rcx
               	movslq	0x20(%rsp,%rax,4), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	sarxq	%rdx, %rcx, %rdx
               	leaq	0x40(%rsp), %rcx
               	movl	0x40(%rsp,%rax,4), %edi
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x20, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<shifts_u32x4>:
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	vpsllvd	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, (%rdi)
               	vpsrlvd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x10(%rdi)
               	retq

<check_u32x4>:
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r12 # imm = 0x14057B7EF767814F
               	addq	%rax, %r12
               	movq	%r12, <rip> # <addr>
               	shrq	$0xb, %r12
               	movl	%r12d, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r13
               	andq	$0x1f, %r13
               	movl	%r13d, 0x40(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r14 # imm = 0x14057B7EF767814F
               	addq	%rax, %r14
               	movq	%r14, <rip> # <addr>
               	shrq	$0xb, %r14
               	movl	%r14d, 0x34(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r15
               	andq	$0x1f, %r15
               	movl	%r15d, 0x44(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rbp # imm = 0x14057B7EF767814F
               	addq	%rax, %rbp
               	movq	%rbp, <rip> # <addr>
               	shrq	$0xb, %rbp
               	movl	%ebp, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %rcx
               	andq	$0x1f, %rcx
               	movl	%ecx, 0x48(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r8 # imm = 0x14057B7EF767814F
               	addq	%rax, %r8
               	movq	%r8, <rip> # <addr>
               	shrq	$0xb, %r8
               	movl	%r8d, 0x3c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r9
               	andq	$0x1f, %r9
               	movl	%r9d, 0x4c(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	movq	%r8, 0x80(%rsp)
               	movq	%r9, 0x78(%rsp)
               	leaq	0x50(%rsp), %rdi
               	leaq	0x30(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	movq	0x88(%rsp), %rcx
               	movq	0x80(%rsp), %r8
               	movq	0x78(%rsp), %r9
               	shlxq	%r13, %r12, %rax
               	movl	%r12d, %edx
               	shrxq	%r13, %rdx, %rdx
               	movl	0x50(%rsp), %esi
               	cmpl	%eax, %esi
               	jne	<addr>
               	movl	0x60(%rsp), %eax
               	cmpl	%edx, %eax
               	jne	<addr>
               	shlxq	%r15, %r14, %rax
               	movl	%r14d, %edx
               	shrxq	%r15, %rdx, %rdx
               	movl	0x54(%rsp), %esi
               	cmpl	%eax, %esi
               	jne	<addr>
               	movl	0x64(%rsp), %eax
               	nopw	(%rax,%rax)
               	cmpl	%edx, %eax
               	jne	<addr>
               	shlxq	%rcx, %rbp, %rax
               	movl	%ebp, %edx
               	shrxq	%rcx, %rdx, %rcx
               	movl	0x58(%rsp), %edx
               	nopl	(%rax,%rax)
               	cmpl	%eax, %edx
               	jne	<addr>
               	movl	0x68(%rsp), %eax
               	cmpl	%ecx, %eax
               	jne	<addr>
               	shlxq	%r9, %r8, %rax
               	movl	%r8d, %ecx
               	shrxq	%r9, %rcx, %rcx
               	movl	0x5c(%rsp), %edx
               	nopl	(%rax)
               	cmpl	%eax, %edx
               	jne	<addr>
               	movl	0x6c(%rsp), %eax
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x68, %rsp
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x68, %rsp
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x68, %rsp
               	retq

<shifts_s64x2>:
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	vpsllvq	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, (%rdi)
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %rcx
               	sarxq	%rcx, %rax, %rax
               	vpextrq	$0x1, %xmm0, %rcx
               	vpextrq	$0x1, %xmm1, %rdx
               	sarxq	%rdx, %rcx, %rcx
               	movq	%rax, 0x10(%rdi)
               	movq	%rcx, 0x18(%rdi)
               	retq

<check_s64x2>:
               	subq	$0x50, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r12 # imm = 0x14057B7EF767814F
               	addq	%rax, %r12
               	movq	%r12, <rip> # <addr>
               	shrq	$0xb, %r12
               	movq	%r12, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r13
               	andq	$0x3f, %r13
               	movq	%r13, 0x40(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r14 # imm = 0x14057B7EF767814F
               	addq	%rax, %r14
               	movq	%r14, <rip> # <addr>
               	shrq	$0xb, %r14
               	movq	%r14, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r15
               	andq	$0x3f, %r15
               	movq	%r15, 0x48(%rsp)
               	leaq	0x50(%rsp), %rdi
               	leaq	0x30(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	callq	<addr>
               	shlxq	%r13, %r12, %rax
               	sarxq	%r13, %r12, %rcx
               	movq	0x50(%rsp), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	0x60(%rsp), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	shlxq	%r15, %r14, %rax
               	sarxq	%r15, %r14, %rcx
               	movq	0x58(%rsp), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	0x68(%rsp), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	incq	%rbx
               	nopl	(%rax,%rax)
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x50, %rsp
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x50, %rsp
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x50, %rsp
               	retq

<shifts_u64x4>:
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpsllvq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsrlvq	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x20(%rdi)
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
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r12 # imm = 0x14057B7EF767814F
               	addq	%rax, %r12
               	movq	%r12, <rip> # <addr>
               	shrq	$0xb, %r12
               	movq	%r12, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r13
               	andq	$0x3f, %r13
               	movq	%r13, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r14 # imm = 0x14057B7EF767814F
               	addq	%rax, %r14
               	movq	%r14, <rip> # <addr>
               	shrq	$0xb, %r14
               	movq	%r14, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r15
               	andq	$0x3f, %r15
               	movq	%r15, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r8
               	andq	$0x3f, %r8
               	movq	%r8, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r9 # imm = 0x14057B7EF767814F
               	addq	%rax, %r9
               	movq	%r9, <rip> # <addr>
               	shrq	$0xb, %r9
               	movq	%r9, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r10
               	andq	$0x3f, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rcx, -0x8(%rbp)
               	movq	%r8, -0x10(%rbp)
               	movq	%r9, -0x18(%rbp)
               	movq	%r10, -0x20(%rbp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	movq	-0x10(%rbp), %r8
               	movq	-0x18(%rbp), %r9
               	movq	-0x20(%rbp), %r10
               	shlxq	%r13, %r12, %rax
               	shrxq	%r13, %r12, %rdx
               	movq	0x40(%rsp), %rsi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	0x60(%rsp), %rax
               	nopl	(%rax)
               	cmpq	%rdx, %rax
               	jne	<addr>
               	shlxq	%r15, %r14, %rax
               	shrxq	%r15, %r14, %rdx
               	movq	0x48(%rsp), %rsi
               	nopl	(%rax,%rax)
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	0x68(%rsp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	shlxq	%r8, %rcx, %rax
               	shrxq	%r8, %rcx, %rcx
               	movq	0x50(%rsp), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	0x70(%rsp), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	shlxq	%r10, %r9, %rax
               	shrxq	%r10, %r9, %rcx
               	movq	0x58(%rsp), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	0x78(%rsp), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	incq	%rbx
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %ebx
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
               	movl	$0x10, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xf, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
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
               	xorl	%eax, %eax
               	popq	%r11
               	retq
