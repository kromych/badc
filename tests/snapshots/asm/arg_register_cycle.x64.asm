
arg_register_cycle.x64:	file format elf64-x86-64

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

<rec>:
               	testl	%edx, %edx
               	je	<addr>
               	pushq	%rax
               	movq	%rdx, %rax
               	subl	$0x1, %eax
               	jne	<addr>
               	movq	%rsi, %rax
               	subq	%rdi, %rax
               	popq	%r11
               	retq
               	nopw	(%rax,%rax)
               	subl	$0x1, %eax
               	jne	<addr>
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	jmp	<addr>
               	leaq	-0x1(%rax), %rdx
               	xchgq	%rsi, %rdi
               	callq	<addr>
               	jmp	<addr>
               	movslq	%edi, %rax
               	movslq	%esi, %r10
               	subq	%r10, %rax
               	retq

<main>:
               	pushq	%rax
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movl	$0x64, %edi
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	cmpl	$-0x63, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
