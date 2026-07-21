
typeof_addr_of_array.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	(%rdx,%rcx,4), %rdi
               	imulq	$0xa, %rcx, %rsi
               	addq	$0xa, %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	(%rdx,%rcx,4), %rdi
               	imulq	$0xa, %rcx, %rsi
               	addq	$0xa, %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
