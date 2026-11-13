
void_return.x64:	file format elf64-x86-64

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

<bump>:
               	addl	$0x1, (%rdi)
               	retq

<copy_pair>:
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	retq

<clamp>:
               	movl	(%rdi), %eax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x0, (%rdi)
               	retq
               	incq	%rax
               	movl	%eax, (%rdi)
               	retq

<forward>:
               	movl	$0x1, (%rdi)
               	retq

<pick>:
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x1, (%rsi)
               	retq
               	movl	$0x2, (%rsi)
               	jmp	<addr>

<discard>:
               	movl	$0x2, (%rdi)
               	retq

<through_typedef>:
               	movl	$0x3, (%rdi)
               	retq

<call_last>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, (%rdi)
               	callq	<addr>
               	popq	%rbp
               	retq

<count_down>:
               	testl	%edi, %edi
               	je	<addr>
               	addl	%edi, (%rsi)
               	decq	%rdi
               	testl	%edi, %edi
               	jne	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x1, -0x8(%rbp)
               	movl	$0x1, -0x8(%rbp)
               	movl	$0x2, -0x8(%rbp)
               	movl	$0x3, -0x8(%rbp)
               	movl	$0x4, -0x8(%rbp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movl	$0x3, %edi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
