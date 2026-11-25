
tail_call_outside_return_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<make>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x3e8, %r8d            # imm = 0x3E8
               	jle	<addr>
               	decq	%r8
               	jmp	<addr>
               	cmpl	$0x40001, %edi          # imm = 0x40001
               	jne	<addr>
               	cmpl	$0x2, %esi
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	cmpl	$0x3, %r8d
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	retq

<wrap>:
               	pushq	%rax
               	orq	$0x40000, %rdi          # imm = 0x40000
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x18(%rax), %rcx
               	testb	$0x4, %cl
               	je	<addr>
               	popq	%r11
               	retq
               	movq	0x10(%rax), %rcx
               	testb	$0x2, %cl
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movq	(%rax), %rcx
               	jmp	<addr>

<main>:
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	movl	$0x7, %ecx
               	movl	$0x3, %r8d
               	callq	*%rax
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
