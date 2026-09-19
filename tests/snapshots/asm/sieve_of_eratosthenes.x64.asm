
sieve_of_eratosthenes.x64:	file format elf64-x86-64

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
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movsbq	(%rdx,%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movl	$0x1, %edi
               	movb	%dil, (%rdx,%rsi)
               	addq	%rcx, %rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	incq	%rcx
               	movslq	%ecx, %rax
               	movq	%rax, %rsi
               	imulq	%rax, %rsi
               	cmpq	$0x186a0, %rsi          # imm = 0x186A0
               	jl	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x2, %eax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movsbq	(%rdx,%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	incq	%rcx
               	incq	%rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	cmpl	$0x2578, %ecx           # imm = 0x2578
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
