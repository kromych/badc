
typeof_conditional_call_decay.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x3, %esi
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	jmp	<addr>
               	incq	%rax
               	leaq	(%rcx,%rax), %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	$0x3, %rax
               	jae	<addr>
               	cmpq	$0x9, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movw	%ax, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movl	%eax, 0x10(%rcx)
               	leave
               	retq
               	movq	%rax, %rsi
               	jmp	<addr>
