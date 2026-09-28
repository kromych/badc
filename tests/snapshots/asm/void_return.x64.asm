
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
               	movslq	(%rdi), %rax
               	incq	%rax
               	movl	%eax, (%rdi)
               	retq

<copy_pair>:
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	retq

<clamp>:
               	movslq	(%rdi), %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x0, (%rdi)
               	retq
               	movslq	(%rdi), %rax
               	incq	%rax
               	movl	%eax, (%rdi)
               	retq

<forward>:
               	movl	$0x1, (%rdi)
               	retq

<pick>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
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
               	movslq	(%rsi), %rax
               	addq	%rdi, %rax
               	movl	%eax, (%rsi)
               	decq	%rdi
               	testl	%edi, %edi
               	jne	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movl	$0x0, (%rax)
               	movl	$0x1, (%rax)
               	cmpl	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x1, (%rax)
               	movl	$0x2, (%rax)
               	movl	$0x3, (%rax)
               	movl	$0x4, (%rax)
               	movq	%rax, %rdi
               	callq	<addr>
               	movl	$0x3, %edi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x2, (%rax)
               	jmp	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
