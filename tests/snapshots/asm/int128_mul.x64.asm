
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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	xorl	%eax, %eax
               	movq	%rsi, %rcx
               	imulq	%rdx, %rcx
               	movl	%esi, %edi
               	movq	%rsi, %r8
               	shrq	$0x20, %r8
               	movl	%edx, %r9d
               	movq	%rdx, %rbx
               	shrq	$0x20, %rbx
               	movq	%rdi, %r12
               	imulq	%r9, %r12
               	shrq	$0x20, %r12
               	imulq	%r8, %r9
               	addq	%r12, %r9
               	movl	%r9d, %r12d
               	shrq	$0x20, %r9
               	movq	%rdi, %r13
               	imulq	%rbx, %r13
               	addq	%r13, %r12
               	shrq	$0x20, %r12
               	imulq	%rbx, %r8
               	addq	%r9, %r8
               	addq	%r12, %r8
               	movq	%rsi, %r9
               	imulq	%rax, %r9
               	imulq	%rdx, %rax
               	addq	%r9, %r8
               	addq	%rax, %r8
               	movabsq	$-0x1a30fba3fb44a2f0, %r11 # imm = 0xE5CF045C04BB5D10
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rsi, %r9
               	shrq	$0x20, %r9
               	movl	%edx, %ebx
               	movq	%rdx, %r12
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
               	movq	%rsi, %r9
               	imulq	%rax, %r9
               	imulq	%rdx, %rax
               	addq	%r9, %rdi
               	addq	%rdi, %rax
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rsi, %rax
               	imulq	%rdx, %rax
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rcx, %rdi
               	imulq	%rcx, %rdi
               	movl	%ecx, %eax
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	movq	%rax, %rsi
               	imulq	%rax, %rsi
               	shrq	$0x20, %rsi
               	imulq	%rdx, %rax
               	addq	%rax, %rsi
               	movl	%esi, %r9d
               	shrq	$0x20, %rsi
               	addq	%r9, %rax
               	shrq	$0x20, %rax
               	imulq	%rdx, %rdx
               	addq	%rsi, %rdx
               	addq	%rax, %rdx
               	movq	%rcx, %rax
               	imulq	%r8, %rax
               	addq	%rax, %rdx
               	addq	%rdx, %rax
               	movabsq	$0x6189c7899734a100, %r11 # imm = 0x6189C7899734A100
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x6a05b5499fbdfde8, %r11 # imm = 0x95FA4AB660420218
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movabsq	$-0x61c8864680b583eb, %rax # imm = 0x9E3779B97F4A7C15
               	movq	%rcx, %rbx
               	imulq	%rax, %rbx
               	movl	%ecx, %edx
               	movq	%rcx, %rsi
               	shrq	$0x20, %rsi
               	movl	$0x7f4a7c15, %edi       # imm = 0x7F4A7C15
               	movl	$0x9e3779b9, %r9d       # imm = 0x9E3779B9
               	movq	%rdx, %r12
               	imulq	%rdi, %r12
               	shrq	$0x20, %r12
               	imulq	%rsi, %rdi
               	addq	%r12, %rdi
               	movl	%edi, %r12d
               	shrq	$0x20, %rdi
               	imulq	%r9, %rdx
               	addq	%r12, %rdx
               	shrq	$0x20, %rdx
               	imulq	%r9, %rsi
               	addq	%rdi, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x0, %rcx, %rcx
               	imulq	%r8, %rax
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movabsq	$-0x1e22f04504ed9db0, %r11 # imm = 0xE1DD0FBAFB126250
               	movq	%rbx, %rcx
               	cmpq	%r11, %rbx
               	jne	<addr>
               	movabsq	$-0x54b9b0367b5ac859, %r11 # imm = 0xAB464FC984A537A7
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
