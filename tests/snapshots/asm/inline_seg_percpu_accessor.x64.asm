
inline_seg_percpu_accessor.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	<rip>, %rdx
               	leaq	0x8(%rdx), %rax
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, (%rax)
               	leaq	0x18(%rdx), %rax
               	movabsq	$-0x6655443322110100, %rcx # imm = 0x99AABBCCDDEEFF00
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x9e, %ecx
               	movl	$0x1001, %esi           # imm = 0x1001
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	-0x28(%rbp), %rax
               	movq	-0x20(%rbp), %rdi
               	movq	-0x18(%rbp), %rsi
               	syscall
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x10, %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x18, %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x10, %rax
               	movl	%gs:(%rax), %eax
               	movl	%eax, %eax
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x4, %rax
               	addq	$0x18, %rax
               	movzwq	%gs:(%rax), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xbbcc, %eax           # imm = 0xBBCC
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x17, %rax
               	movzbq	%gs:(%rax), %rax
               	andq	$0xff, %rax
               	cmpl	$0x99, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	(%rax), %rsi
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	addq	%rcx, %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	%rax, %rcx
               	leaq	(%rcx), %rax
               	movq	%gs:(%rax), %rsi
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	pushfq
               	popq	%rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rdi
               	leaq	(%rcx), %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	movq	%rsi, %r8
               	cmpq	%r11, %rsi
               	jne	<addr>
               	cmpq	%rsi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movabsq	$-0x5a5a5a5a5a5a5a5b, %rax # imm = 0xA5A5A5A5A5A5A5A5
               	leaq	0x38(%rcx), %rsi
               	movq	%rax, %gs:(%rsi)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	pushfq
               	popq	%rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	0x38(%rcx), %rax
               	movq	%gs:(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, %gs:(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movabsq	$0xf1e2d3c4b5a6978, %rsi # imm = 0xF1E2D3C4B5A6978
               	addq	$0x20, %rcx
               	movq	%rsi, %gs:(%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdi
               	shlq	%rdi
               	movabsq	$-0x112053135014111, %r8 # imm = 0xFEEDFACECAFEBEEF
               	addq	%rdi, %rsi
               	movq	%r8, %gs:(%rsi)
               	movq	(%rax), %rsi
               	addq	$0x28, %rsi
               	movq	%gs:(%rsi), %rdi
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	addq	%r11, %rdi
               	movq	%rdi, %gs:(%rsi)
               	movq	(%rcx), %rcx
               	addq	$0x38, %rcx
               	movq	%gs:(%rcx), %rsi
               	addq	$0x3, %rsi
               	movq	%rsi, %gs:(%rcx)
               	movq	(%rax), %rax
               	addq	$0x28, %rax
               	movl	%gs:(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, %gs:(%rax)
               	xorq	%rax, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x9e, %esi
               	movl	$0x1001, %edi           # imm = 0x1001
               	movq	%rcx, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x28(%rbp), %rax
               	movq	-0x20(%rbp), %rdi
               	movq	-0x18(%rbp), %rsi
               	syscall
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	0x28(%rdx), %rax
               	movq	(%rax), %rax
               	movabsq	$0xf1e2d3c4b5a6978, %r11 # imm = 0xF1E2D3C4B5A6978
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	0x10(%rdx), %rax
               	movq	(%rax), %rax
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	0x30(%rdx), %rax
               	movq	(%rax), %rax
               	movabsq	$0x1111111111111112, %r11 # imm = 0x1111111111111112
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	(%rdx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x20(%rdx), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x38(%rdx), %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	0x40(%rdx), %rax
               	movq	(%rax), %rax
               	movabsq	$-0x5a5a5a5a5a5a5a5a, %r11 # imm = 0xA5A5A5A5A5A5A5A6
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	0x48(%rdx), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x50(%rdx), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x58(%rdx), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
