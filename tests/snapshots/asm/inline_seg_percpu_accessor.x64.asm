
inline_seg_percpu_accessor.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<pcpu_read64>:
               	leaq	(%rdi,%rsi), %rax
               	movq	%gs:(%rax), %rax
               	retq

<pcpu_read32>:
               	leaq	0x10(%rdi), %rax
               	movl	%gs:(%rax), %eax
               	movl	%eax, %eax
               	retq

<pcpu_read16>:
               	leaq	0x18(%rsi), %rax
               	movzwq	%gs:(%rax), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<pcpu_read8>:
               	leaq	0x17(%rdi), %rax
               	movzbq	%gs:(%rax), %rax
               	andq	$0xff, %rax
               	retq

<pcpu_write64>:
               	leaq	(%rdi,%rsi), %rax
               	movq	%rdx, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<pcpu_add64>:
               	leaq	(%rdi,%rsi), %rax
               	movq	%gs:(%rax), %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<pcpu_inc32>:
               	leaq	0x28(%rdi), %rax
               	movl	%gs:(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rbx
               	leaq	0x8(%rbx), %rax
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, (%rax)
               	leaq	0x18(%rbx), %rax
               	movabsq	$-0x6655443322110100, %rcx # imm = 0x99AABBCCDDEEFF00
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x9e, %ecx
               	movl	$0x1001, %edx           # imm = 0x1001
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	movq	%r11, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rbx, -0x20(%rbp)
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
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	callq	<addr>
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0x10, %esi
               	callq	<addr>
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x18, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	callq	<addr>
               	movabsq	$-0x6655443322110100, %r11 # imm = 0x99AABBCCDDEEFF00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0x10, %esi
               	callq	<addr>
               	movl	$0xddeeff00, %r11d      # imm = 0xDDEEFF00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x18, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	0x4(%rax), %rsi
               	callq	<addr>
               	cmpq	$0xbbcc, %rax           # imm = 0xBBCC
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0x17, %esi
               	callq	<addr>
               	cmpq	$0x99, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r13
               	movq	(%r13), %rdi
               	leaq	<rip>, %r12
               	movq	(%r12), %rsi
               	callq	<addr>
               	movq	(%r12), %rdi
               	movl	$0x17, %esi
               	callq	<addr>
               	movq	(%r13), %rdi
               	movq	(%r12), %rsi
               	callq	<addr>
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	(%rax,%rcx), %r12
               	xorq	%r13, %r13
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	pushfq
               	popq	%rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x8(%rbp), %r15
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	movq	%r14, %rax
               	cmpq	%r11, %r14
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	%r14, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	testq	%r15, %r15
               	jne	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x38, %esi
               	movabsq	$-0x5a5a5a5a5a5a5a5b, %rdx # imm = 0xA5A5A5A5A5A5A5A5
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	pushfq
               	popq	%rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x38, %r13d
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rdi
               	movl	$0x20, %esi
               	movabsq	$0xf1e2d3c4b5a6978, %rdx # imm = 0xF1E2D3C4B5A6978
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rdi
               	movq	(%r12), %rax
               	movq	%rax, %rsi
               	shlq	%rsi
               	movabsq	$-0x112053135014111, %rdx # imm = 0xFEEDFACECAFEBEEF
               	callq	<addr>
               	movq	(%r12), %rdi
               	movl	$0x28, %r15d
               	movabsq	$0x1111111111111111, %rdx # imm = 0x1111111111111111
               	movq	%r15, %rsi
               	callq	<addr>
               	movq	(%r14), %rdi
               	movl	$0x3, %edx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	(%r12), %rdi
               	movq	%r15, %rsi
               	callq	<addr>
               	xorq	%rax, %rax
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
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0x28(%rbx), %rax
               	movq	(%rax), %rax
               	movabsq	$0xf1e2d3c4b5a6978, %r11 # imm = 0xF1E2D3C4B5A6978
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0x10(%rbx), %rax
               	movq	(%rax), %rax
               	movabsq	$-0x112053135014111, %r11 # imm = 0xFEEDFACECAFEBEEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0x30(%rbx), %rax
               	movq	(%rax), %rax
               	movabsq	$0x1111111111111112, %r11 # imm = 0x1111111111111112
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x20(%rbx), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x38(%rbx), %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0x40(%rbx), %rax
               	movq	(%rax), %rax
               	movabsq	$-0x5a5a5a5a5a5a5a5a, %r11 # imm = 0xA5A5A5A5A5A5A5A6
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0x48(%rbx), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x50(%rbx), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x58(%rbx), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
