
forward_fn_ptr_in_static_init.x64:	file format elf64-x86-64

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

<add_two>:
               	leaq	0x2(%rdi), %rax
               	retq

<times_three>:
               	leaq	(%rdi,%rdi,2), %rax
               	retq

<minus_seven>:
               	leaq	-0x7(%rdi), %rax
               	retq

<main>:
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	movl	$0xa, %edi
               	callq	*%rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x5, %edi
               	callq	*%rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x64, %edi
               	callq	*%rax
               	cmpl	$0x5d, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
