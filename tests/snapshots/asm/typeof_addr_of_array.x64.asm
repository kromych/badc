
typeof_addr_of_array.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movslq	(%rcx,%rdx,4), %rdi
               	imulq	$0xa, %rdx, %rsi
               	addq	$0xa, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movslq	(%rcx,%rdx,4), %rdi
               	imulq	$0xa, %rdx, %rsi
               	addq	$0xa, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x3, %eax
               	retq
