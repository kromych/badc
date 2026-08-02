
int128_struct_fallback.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2a0, %rsp            # imm = 0x2A0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movabsq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	addq	%r12, %rcx
               	cmpq	%r12, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	leaq	(%rax), %rdx
               	leaq	-0xa8(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0xa8(%rbp), %rax
               	movq	%rcx, (%rax)
               	leaq	-0xa8(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0xa8(%rbp), %rax
               	movq	(%rax), %r13
               	movq	0x8(%rax), %r14
               	testq	%r13, %r13
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x1, %r14
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r12, %rdx
               	subq	%rcx, %rdx
               	movq	0x38(%rsp), %rsi
               	subq	$0x0, %rsi
               	cmpq	%rcx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0xa0(%rbp), %rax
               	movq	%rdx, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	cmpq	$-0x1, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rdx, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	incq	%rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	leaq	-0x1(%rax), %rdx
               	leaq	-0x98(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x98(%rbp), %rax
               	movq	%rcx, (%rax)
               	leaq	-0x98(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	cmpq	$-0x1, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$-0x1, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorq	%rdx, %rdx
               	movq	%rax, %rcx
               	shlq	$0x0, %rcx
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0xa0(%rbp), %rax
               	movq	%rdx, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorq	%rdx, %rdx
               	movq	%rax, %rcx
               	shlq	$0x24, %rcx
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0xa0(%rbp), %rax
               	movq	%rdx, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, %rdx
               	shrq	$0x4, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3c, %rsi
               	orq	%rsi, %rdx
               	sarq	$0x4, %rcx
               	leaq	-0xb0(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0xb0(%rbp), %rax
               	movq	%rdx, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xb0(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x800000000000000, %r11 # imm = 0xF800000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdx
               	cmpq	%r15, %r13
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorq	%rcx, %rcx
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpq	%rdx, %r14
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	cmpq	%rcx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	cmpq	%rcx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
