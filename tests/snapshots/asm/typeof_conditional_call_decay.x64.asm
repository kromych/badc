
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
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	je	<addr>
               	movl	$0x2, %eax
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
               	retq
               	xorq	%rax, %rax
               	retq
               	movq	%rax, %rsi
               	jmp	<addr>
