
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
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %r8
               	xorl	%esi, %esi
               	movq	%rdi, %rcx
               	imulq	%r8, %rcx
               	movq	%rdi, %rax
               	mulq	%r8
               	movq	%rdx, %r9
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	imulq	%rsi, %r8
               	leaq	(%r9,%rax), %rdx
               	leaq	(%rdx,%r8), %rdi
               	movabsq	$-0x1a30fba3fb44a2f0, %r11 # imm = 0xE5CF045C04BB5D10
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	movq	%rdi, %rdx
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x1, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	retq
               	addq	%r9, %rax
               	addq	%r8, %rax
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rcx, %rsi
               	imulq	%rcx, %rsi
               	movq	%rcx, %rax
               	mulq	%rcx
               	movq	%rcx, %rax
               	imulq	%rdi, %rax
               	addq	%rax, %rdx
               	addq	%rdx, %rax
               	movabsq	$0x6189c7899734a100, %r11 # imm = 0x6189C7899734A100
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x6a05b5499fbdfde8, %r11 # imm = 0x95FA4AB660420218
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movabsq	$-0x61c8864680b583eb, %rsi # imm = 0x9E3779B97F4A7C15
               	movq	%rcx, %r8
               	imulq	%rsi, %r8
               	movq	%rcx, %rax
               	mulq	%rsi
               	imulq	$0x0, %rcx, %rax
               	imulq	%rdi, %rsi
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	movabsq	$-0x1e22f04504ed9db0, %r11 # imm = 0xE1DD0FBAFB126250
               	movq	%r8, %rcx
               	cmpq	%r11, %r8
               	jne	<addr>
               	movabsq	$-0x54b9b0367b5ac859, %r11 # imm = 0xAB464FC984A537A7
               	cmpq	%r11, %rax
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
