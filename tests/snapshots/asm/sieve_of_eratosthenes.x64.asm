
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
               	movslq	%ecx, %rax
               	movq	%rax, %rsi
               	imulq	%rax, %rsi
               	cmpq	$0x186a0, %rsi          # imm = 0x186A0
               	jge	<addr>
               	cmpb	$0x0, (%rdx,%rax)
               	jne	<addr>
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jge	<addr>
               	movslq	%eax, %rsi
               	movb	$0x1, (%rdx,%rsi)
               	addq	%rcx, %rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	incq	%rcx
               	movslq	%ecx, %rax
               	movq	%rax, %rsi
               	imulq	%rax, %rsi
               	cmpq	$0x186a0, %rsi          # imm = 0x186A0
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x2, %eax
               	leaq	<rip>, %rdx
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jge	<addr>
               	cmpb	$0x0, (%rdx,%rax)
               	jne	<addr>
               	incq	%rcx
               	incq	%rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	cmpl	$0x2578, %ecx           # imm = 0x2578
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
