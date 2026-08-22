
int128_mul.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	xorq	%rsi, %rsi
               	movq	%rax, %rdx
               	imulq	%rcx, %rdx
               	movl	%eax, %edi
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	movl	%ecx, %r9d
               	movq	%rcx, %rbx
               	shrq	$0x20, %rbx
               	movq	%rdi, %r12
               	imulq	%r9, %r12
               	shrq	$0x20, %r12
               	imulq	%r8, %r9
               	addq	%r12, %r9
               	movl	%r9d, %r12d
               	shrq	$0x20, %r9
               	imulq	%rbx, %rdi
               	addq	%r12, %rdi
               	shrq	$0x20, %rdi
               	imulq	%rbx, %r8
               	addq	%r9, %r8
               	addq	%r8, %rdi
               	movq	%rax, %r8
               	imulq	%rsi, %r8
               	imulq	%rcx, %rsi
               	addq	%r8, %rdi
               	addq	%rdi, %rsi
               	movabsq	$-0x1a30fba3fb44a2f0, %r11 # imm = 0xE5CF045C04BB5D10
               	movq	%rdx, %rdi
               	cmpq	%r11, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %edi
               	testq	%rdi, %rdi
               	je	<addr>
               	movslq	%edi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movl	%eax, %edi
               	movq	%rax, %r9
               	shrq	$0x20, %r9
               	movl	%ecx, %ebx
               	movq	%rcx, %r12
               	shrq	$0x20, %r12
               	movq	%rdi, %r13
               	imulq	%rbx, %r13
               	shrq	$0x20, %r13
               	imulq	%r9, %rbx
               	addq	%r13, %rbx
               	movl	%ebx, %r13d
               	shrq	$0x20, %rbx
               	imulq	%r12, %rdi
               	addq	%r13, %rdi
               	shrq	$0x20, %rdi
               	imulq	%r12, %r9
               	addq	%rbx, %r9
               	addq	%r9, %rdi
               	movq	%rax, %r9
               	imulq	%r8, %r9
               	imulq	%rcx, %r8
               	addq	%r9, %rdi
               	addq	%rdi, %r8
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%r8, %rdi
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %r13
               	imulq	%rcx, %r13
               	imulq	%rcx, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %r9
               	imulq	%rdx, %r9
               	movl	%edx, %eax
               	movq	%rdx, %rcx
               	shrq	$0x20, %rcx
               	movl	%edx, %edi
               	movq	%rdx, %r8
               	shrq	$0x20, %r8
               	movq	%rax, %rbx
               	imulq	%rdi, %rbx
               	shrq	$0x20, %rbx
               	imulq	%rcx, %rdi
               	addq	%rbx, %rdi
               	movl	%edi, %ebx
               	shrq	$0x20, %rdi
               	imulq	%r8, %rax
               	addq	%rbx, %rax
               	shrq	$0x20, %rax
               	imulq	%r8, %rcx
               	addq	%rdi, %rcx
               	addq	%rcx, %rax
               	movq	%rdx, %rcx
               	imulq	%rsi, %rcx
               	movq	%rsi, %rdi
               	imulq	%rdx, %rdi
               	addq	%rcx, %rax
               	leaq	(%rax,%rdi), %rcx
               	movabsq	$0x6189c7899734a100, %r11 # imm = 0x6189C7899734A100
               	movq	%r9, %rax
               	cmpq	%r11, %r9
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x6a05b5499fbdfde8, %r11 # imm = 0x95FA4AB660420218
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	movq	%rdx, %rbx
               	imulq	%rax, %rbx
               	movl	%edx, %ecx
               	movq	%rdx, %rdi
               	shrq	$0x20, %rdi
               	movl	$0x7f4a7c15, %r8d       # imm = 0x7F4A7C15
               	movl	$0x9e3779b9, %r9d       # imm = 0x9E3779B9
               	movq	%rcx, %r12
               	imulq	%r8, %r12
               	shrq	$0x20, %r12
               	imulq	%rdi, %r8
               	addq	%r12, %r8
               	movl	%r8d, %r12d
               	shrq	$0x20, %r8
               	imulq	%r9, %rcx
               	addq	%r12, %rcx
               	shrq	$0x20, %rcx
               	imulq	%r9, %rdi
               	addq	%r8, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x0, %rdx, %rdx
               	imulq	%rsi, %rax
               	addq	%rdx, %rcx
               	addq	%rax, %rcx
               	movabsq	$-0x1e22f04504ed9db0, %r11 # imm = 0xE1DD0FBAFB126250
               	movq	%rbx, %rax
               	cmpq	%r11, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x54b9b0367b5ac859, %r11 # imm = 0xAB464FC984A537A7
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	jmp	<addr>
