
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
               	xorq	%rdi, %rdi
               	movq	%rax, %rdx
               	imulq	%rcx, %rdx
               	movl	%eax, %esi
               	movq	%rax, %r8
               	shrq	$0x20, %r8
               	movl	%ecx, %r9d
               	movq	%rcx, %rbx
               	shrq	$0x20, %rbx
               	movq	%rsi, %r12
               	imulq	%r9, %r12
               	shrq	$0x20, %r12
               	imulq	%r8, %r9
               	addq	%r12, %r9
               	movl	%r9d, %r12d
               	shrq	$0x20, %r9
               	movq	%rsi, %r13
               	imulq	%rbx, %r13
               	addq	%r13, %r12
               	shrq	$0x20, %r12
               	imulq	%rbx, %r8
               	addq	%r9, %r8
               	addq	%r12, %r8
               	movq	%rax, %r9
               	imulq	%rdi, %r9
               	imulq	%rcx, %rdi
               	addq	%r9, %r8
               	addq	%r8, %rdi
               	movabsq	$-0x1a30fba3fb44a2f0, %r11 # imm = 0xE5CF045C04BB5D10
               	movq	%rdx, %r8
               	cmpq	%r11, %rdx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%rdi, %r8
               	cmpq	%r11, %rdi
               	setne	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x1, %r8d
               	testq	%r8, %r8
               	je	<addr>
               	movslq	%r8d, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%rax, %r9
               	shrq	$0x20, %r9
               	movl	%ecx, %ebx
               	movq	%rcx, %r12
               	shrq	$0x20, %r12
               	movq	%rsi, %r13
               	imulq	%rbx, %r13
               	shrq	$0x20, %r13
               	imulq	%r9, %rbx
               	addq	%r13, %rbx
               	movl	%ebx, %r13d
               	shrq	$0x20, %rbx
               	imulq	%r12, %rsi
               	addq	%r13, %rsi
               	shrq	$0x20, %rsi
               	imulq	%r12, %r9
               	addq	%rbx, %r9
               	addq	%r9, %rsi
               	movq	%rax, %r9
               	imulq	%r8, %r9
               	imulq	%rcx, %r8
               	addq	%r9, %rsi
               	addq	%rsi, %r8
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%r8, %rsi
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
               	movq	%rax, %rsi
               	imulq	%rax, %rsi
               	movq	%rsi, %r8
               	shrq	$0x20, %r8
               	movq	%rcx, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %r8
               	movl	%r8d, %ebx
               	shrq	$0x20, %r8
               	leaq	(%rsi,%rbx), %rax
               	shrq	$0x20, %rax
               	imulq	%rcx, %rcx
               	addq	%r8, %rcx
               	addq	%rax, %rcx
               	movq	%rdx, %rax
               	imulq	%rdi, %rax
               	addq	%rax, %rcx
               	addq	%rax, %rcx
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
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movabsq	$-0x61c8864680b583eb, %rax # imm = 0x9E3779B97F4A7C15
               	movq	%rdx, %rbx
               	imulq	%rax, %rbx
               	movl	%edx, %ecx
               	movq	%rdx, %rsi
               	shrq	$0x20, %rsi
               	movl	$0x7f4a7c15, %r8d       # imm = 0x7F4A7C15
               	movl	$0x9e3779b9, %r9d       # imm = 0x9E3779B9
               	movq	%rcx, %r12
               	imulq	%r8, %r12
               	shrq	$0x20, %r12
               	imulq	%rsi, %r8
               	addq	%r12, %r8
               	movl	%r8d, %r12d
               	shrq	$0x20, %r8
               	imulq	%r9, %rcx
               	addq	%r12, %rcx
               	shrq	$0x20, %rcx
               	imulq	%r9, %rsi
               	addq	%r8, %rsi
               	addq	%rsi, %rcx
               	imulq	$0x0, %rdx, %rdx
               	imulq	%rdi, %rax
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
               	xorq	%r8, %r8
               	jmp	<addr>
               	jmp	<addr>
