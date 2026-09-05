
pointer_to_array_cast.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rsi
               	movslq	%eax, %rcx
               	leaq	(%rcx,%rcx,2), %rdx
               	movslq	%edx, %rdi
               	movw	%di, (%rsi,%rcx,2)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movswq	0x14(%rax), %rcx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movswq	0xc(%rax), %rax
               	cmpl	$0x12, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
