
function_returning_pointer_to_array.x64:	file format elf64-x86-64

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

<half>:
               	vdivsd	<rip>, %xmm0, %xmm0
               	retq

<twice>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<mki>:
               	leaq	<rip>, %rax # <addr>
               	retq

<mkf>:
               	leaq	<rip>, %rax # <addr>
               	retq

<main>:
               	pushq	%rax
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movl	$0xa, %eax
               	popq	%r11
               	retq
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	movl	$0x3, %eax
               	popq	%r11
               	retq

<mkl>:
               	leaq	<rip>, %rax # <addr>
               	retq

<sig>:
               	testl	%edi, %edi
               	je	<addr>
               	leaq	-<rip>, %rax # <addr>
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
