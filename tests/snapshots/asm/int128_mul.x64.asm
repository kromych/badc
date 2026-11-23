
int128_mul.x64:	file format elf64-x86-64

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

<main>:
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	xorl	%ecx, %ecx
               	movq	%rdi, %rsi
               	imulq	%r8, %rsi
               	movq	%rdi, %rax
               	mulq	%r8
               	movq	%rdx, %r9
               	imulq	%rcx, %rdi
               	imulq	%rcx, %r8
               	leaq	(%r9,%rdi), %rax
               	leaq	(%rax,%r8), %rdx
               	movabsq	$-0x1a30fba3fb44a2f0, %r11 # imm = 0xE5CF045C04BB5D10
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	leaq	(%r9,%rdi), %rax
               	addq	%r8, %rax
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rsi, %rcx
               	imulq	%rsi, %rcx
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	movq	%rsi, %rax
               	imulq	%rdx, %rax
               	addq	%rax, %rdi
               	addq	%rax, %rdi
               	movabsq	$0x6189c7899734a100, %r11 # imm = 0x6189C7899734A100
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x6a05b5499fbdfde8, %r11 # imm = 0x95FA4AB660420218
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movabsq	$-0x61c8864680b583eb, %rcx # imm = 0x9E3779B97F4A7C15
               	movq	%rsi, %rdi
               	imulq	%rcx, %rdi
               	pushq	%rdx
               	movq	%rsi, %rax
               	mulq	%rcx
               	movq	%rdx, %rax
               	popq	%rdx
               	imulq	$0x0, %rsi, %rsi
               	imulq	%rdx, %rcx
               	addq	%rsi, %rax
               	addq	%rax, %rcx
               	movabsq	$-0x1e22f04504ed9db0, %r11 # imm = 0xE1DD0FBAFB126250
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x54b9b0367b5ac859, %r11 # imm = 0xAB464FC984A537A7
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
