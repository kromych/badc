
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	%rax, %rcx
               	imulq	%rsi, %rcx
               	mulq	%rsi
               	movq	%rdx, %rsi
               	movabsq	$-0x1a30fba3fb44a2f0, %r11 # imm = 0xE5CF045C04BB5D10
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rcx, %rdi
               	imulq	%rcx, %rdi
               	movq	%rcx, %rax
               	mulq	%rcx
               	movq	%rcx, %rax
               	imulq	%rsi, %rax
               	addq	%rax, %rdx
               	addq	%rax, %rdx
               	movabsq	$0x6189c7899734a100, %r11 # imm = 0x6189C7899734A100
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x6a05b5499fbdfde8, %r11 # imm = 0x95FA4AB660420218
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movabsq	$-0x61c8864680b583eb, %rdi # imm = 0x9E3779B97F4A7C15
               	movq	%rcx, %r8
               	imulq	%rdi, %r8
               	movq	%rcx, %rax
               	mulq	%rdi
               	imulq	%rsi, %rdi
               	leaq	(%rdx,%rdi), %rcx
               	movabsq	$-0x1e22f04504ed9db0, %r11 # imm = 0xE1DD0FBAFB126250
               	movq	%r8, %rax
               	cmpq	%r11, %r8
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
               	xorl	%eax, %eax
               	jmp	<addr>
