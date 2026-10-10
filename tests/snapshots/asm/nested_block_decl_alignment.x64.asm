
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
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rcx
               	xorl	%eax, %eax
               	movb	$0x7, (%rsp)
               	testb	$0x3f, %cl
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq

<nested_auto_typed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rcx
               	xorl	%eax, %eax
               	movl	$0x9, (%rsp)
               	testb	$0x3f, %cl
               	jne	<addr>
               	movl	(%rsp), %eax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rcx      # <addr>
               	xorl	%eax, %eax
               	movl	$0x3, (%rcx)
               	testb	$0x3f, %cl
               	jne	<addr>
               	movl	(%rcx), %ecx
               	xorq	$0x3, %rcx
               	testl	%ecx, %ecx
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rcx      # <addr>
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
               	popq	%rbx
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
