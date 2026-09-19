
static_over_alignment.x64:	file format elf64-x86-64

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
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movb	$0x9, (%rax)
               	movq	%rax, %rdx
               	andq	$0xfff, %rdx            # imm = 0xFFF
               	testl	%edx, %edx
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	movsbq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	(%rax), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0x7f, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movq	(%rax), %rax
               	jmp	<addr>
