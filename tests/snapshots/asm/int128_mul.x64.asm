
int128_mul.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mulhi>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	movl	%edi, %eax
               	movq	%rdi, %rdx
               	shrq	$0x20, %rdx
               	movl	%esi, %r8d
               	movq	%rsi, %r9
               	shrq	$0x20, %r9
               	movq	%rax, %rbx
               	imulq	%r8, %rbx
               	shrq	$0x20, %rbx
               	imulq	%rdx, %r8
               	addq	%rbx, %r8
               	movl	%r8d, %ebx
               	shrq	$0x20, %r8
               	imulq	%r9, %rax
               	addq	%rbx, %rax
               	shrq	$0x20, %rax
               	imulq	%r9, %rdx
               	addq	%r8, %rdx
               	addq	%rdx, %rax
               	movq	%rdi, %rdx
               	imulq	%rcx, %rdx
               	imulq	%rsi, %rcx
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	andq	$-0x10, %rsp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	leaq	<rip>, %rax
               	movq	(%rax), %r13
               	xorq	%rcx, %rcx
               	movq	%r12, %rbx
               	imulq	%r13, %rbx
               	movl	%r12d, %eax
               	movq	%r12, %rdx
               	shrq	$0x20, %rdx
               	movl	%r13d, %esi
               	movq	%r13, %rdi
               	shrq	$0x20, %rdi
               	movq	%rax, %r8
               	imulq	%rsi, %r8
               	shrq	$0x20, %r8
               	imulq	%rdx, %rsi
               	addq	%r8, %rsi
               	movl	%esi, %r8d
               	shrq	$0x20, %rsi
               	imulq	%rdi, %rax
               	addq	%r8, %rax
               	shrq	$0x20, %rax
               	imulq	%rdi, %rdx
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	%r12, %rdx
               	imulq	%rcx, %rdx
               	imulq	%r13, %rcx
               	addq	%rdx, %rax
               	leaq	(%rax,%rcx), %r14
               	movabsq	$-0x1a30fba3fb44a2f0, %r11 # imm = 0xE5CF045C04BB5D10
               	movq	%rbx, %rcx
               	cmpq	%r11, %rbx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%r14, %rcx
               	cmpq	%r11, %r14
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x20(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x20(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %r8
               	imulq	%r13, %r8
               	movq	%r12, %rax
               	imulq	%r13, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x20(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	imulq	%rbx, %rdi
               	movl	%ebx, %eax
               	movq	%rbx, %rcx
               	shrq	$0x20, %rcx
               	movl	%ebx, %edx
               	movq	%rbx, %rsi
               	shrq	$0x20, %rsi
               	movq	%rax, %r8
               	imulq	%rdx, %r8
               	shrq	$0x20, %r8
               	imulq	%rcx, %rdx
               	addq	%r8, %rdx
               	movl	%edx, %r8d
               	shrq	$0x20, %rdx
               	imulq	%rsi, %rax
               	addq	%r8, %rax
               	shrq	$0x20, %rax
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rbx, %rcx
               	imulq	%r14, %rcx
               	movq	%r14, %rdx
               	imulq	%rbx, %rdx
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movabsq	$0x6189c7899734a100, %r11 # imm = 0x6189C7899734A100
               	movq	%rdi, %rcx
               	cmpq	%r11, %rdi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x6a05b5499fbdfde8, %r11 # imm = 0x95FA4AB660420218
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x20(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movabsq	$-0x61c8864680b583eb, %rax # imm = 0x9E3779B97F4A7C15
               	movq	%rbx, %r8
               	imulq	%rax, %r8
               	movl	%ebx, %ecx
               	movq	%rbx, %rdx
               	shrq	$0x20, %rdx
               	movl	$0x7f4a7c15, %esi       # imm = 0x7F4A7C15
               	movl	$0x9e3779b9, %edi       # imm = 0x9E3779B9
               	movq	%rcx, %r9
               	imulq	%rsi, %r9
               	shrq	$0x20, %r9
               	imulq	%rdx, %rsi
               	addq	%r9, %rsi
               	movl	%esi, %r9d
               	shrq	$0x20, %rsi
               	imulq	%rdi, %rcx
               	addq	%r9, %rcx
               	shrq	$0x20, %rcx
               	imulq	%rdi, %rdx
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x0, %rbx, %rdx
               	imulq	%r14, %rax
               	addq	%rdx, %rcx
               	leaq	(%rcx,%rax), %rdx
               	movabsq	$-0x1e22f04504ed9db0, %r11 # imm = 0xE1DD0FBAFB126250
               	movq	%r8, %rcx
               	cmpq	%r11, %r8
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x54b9b0367b5ac859, %r11 # imm = 0xAB464FC984A537A7
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x20(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x20(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
