
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
               	subq	$0x60, %rsp
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rcx
               	movabsq	$0x1122334455667788, %rdx # imm = 0x1122334455667788
               	movq	%rdx, (%rcx)
               	leaq	0x18(%rax), %rcx
               	movabsq	$-0x6655443322110100, %rdx # imm = 0x99AABBCCDDEEFF00
               	movq	%rdx, (%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x9e, %edx
               	movl	$0x1001, %esi           # imm = 0x1001
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	movq	%r11, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdi
               	movq	-0x20(%rbp), %rsi
               	syscall
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	-0x50(%rbp), %rsi
               	movq	-0x48(%rbp), %rdi
               	movq	-0x40(%rbp), %r11
               	movq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	%gs:(%rcx), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x10, %rcx
               	movq	%gs:(%rcx), %rcx
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x18, %rcx
               	movq	%gs:(%rcx), %rcx
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x10, %rcx
               	movl	%gs:(%rcx), %ecx
               	movl	%ecx, %ecx
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x4, %rcx
               	addq	$0x18, %rcx
               	movzwq	%gs:(%rcx), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpq	$0xbbcc, %rcx           # imm = 0xBBCC
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x17, %rcx
               	movzbq	%gs:(%rcx), %rcx
               	andq	$0xff, %rcx
               	cmpq	$0x99, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdi
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdx
               	movq	(%rcx), %rcx
               	addq	%rdx, %rcx
               	movq	%gs:(%rcx), %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	(%rcx), %rdx
               	movq	%gs:(%rdx), %rsi
               	leaq	-0x8(%rbp), %rdx
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	pushfq
               	popq	%rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x8(%rbp), %rdi
               	leaq	(%rcx), %rdx
               	movq	%gs:(%rdx), %r8
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	%rsi, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0xf, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5a5a5a5a5a5a5a5b, %rsi # imm = 0xA5A5A5A5A5A5A5A5
               	leaq	0x38(%rcx), %rdx
               	movq	%rsi, %gs:(%rdx)
               	leaq	-0x8(%rbp), %rsi
               	movq	%rax, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	pushfq
               	popq	%rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x8(%rbp), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x10, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	%gs:(%rdx), %rcx
               	incq	%rcx
               	movq	%rcx, %gs:(%rdx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movabsq	$0xf1e2d3c4b5a6978, %rsi # imm = 0xF1E2D3C4B5A6978
               	addq	$0x20, %rdx
               	movq	%rsi, %gs:(%rdx)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	(%rcx), %rdi
               	shlq	%rdi
               	movabsq	$-0x112053135014111, %r8 # imm = 0xFEEDFACECAFEBEEF
               	addq	%rdi, %rsi
               	movq	%r8, %gs:(%rsi)
               	movq	(%rcx), %rsi
               	addq	$0x28, %rsi
               	movq	%gs:(%rsi), %rdi
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	addq	%r11, %rdi
               	movq	%rdi, %gs:(%rsi)
               	movq	(%rdx), %rdx
               	addq	$0x38, %rdx
               	movq	%gs:(%rdx), %rsi
               	addq	$0x3, %rsi
               	movq	%rsi, %gs:(%rdx)
               	movq	(%rcx), %rcx
               	addq	$0x28, %rcx
               	movl	%gs:(%rcx), %edx
               	incq	%rdx
               	movl	%edx, %gs:(%rcx)
               	xorq	%rcx, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x9e, %esi
               	movl	$0x1001, %edi           # imm = 0x1001
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	movq	%r11, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdi, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdi
               	movq	-0x20(%rbp), %rsi
               	syscall
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	-0x50(%rbp), %rsi
               	movq	-0x48(%rbp), %rdi
               	movq	-0x40(%rbp), %r11
               	movq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0x28(%rax), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xf1e2d3c4b5a6978, %r11 # imm = 0xF1E2D3C4B5A6978
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0x10(%rax), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0x30(%rax), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0x1111111111111112, %r11 # imm = 0x1111111111111112
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	(%rax), %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x20(%rax), %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x38(%rax), %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x3, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0x40(%rax), %rdx
               	movq	(%rdx), %rdx
               	movabsq	$-0x5a5a5a5a5a5a5a5a, %r11 # imm = 0xA5A5A5A5A5A5A5A6
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0x48(%rax), %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x50(%rax), %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	addq	$0x58, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
