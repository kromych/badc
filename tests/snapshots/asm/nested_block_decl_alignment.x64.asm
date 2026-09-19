
nested_block_decl_alignment.x64:	file format elf64-x86-64

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

<nested_auto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rcx
               	xorl	%eax, %eax
               	movb	$0x7, (%rcx)
               	testb	$0x3f, %cl
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<nested_auto_typed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	xorl	%ecx, %ecx
               	movl	$0x9, (%rax)
               	testb	$0x3f, %al
               	jne	<addr>
               	movl	(%rax), %eax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movl	$0x3, (%rcx)
               	testb	$0x3f, %cl
               	jne	<addr>
               	movl	(%rcx), %ecx
               	xorq	$0x3, %rcx
               	testl	%ecx, %ecx
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rcx
               	movb	$0x5, (%rcx)
               	testb	$0x7f, %cl
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$0x5, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	(%rdx,%rax), %rbx
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
