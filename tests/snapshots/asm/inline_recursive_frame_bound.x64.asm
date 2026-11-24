
inline_recursive_frame_bound.x64:	file format elf64-x86-64

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

<scale>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	retq

<rec>:
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r14
               	movq	%rsi, %r12
               	xorl	%ebx, %ebx
               	leaq	(%r12,%rbx), %rdi
               	callq	<addr>
               	movl	%eax, 0x20(%rsp,%rbx,4)
               	incq	%rbx
               	cmpl	$0x40, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	movl	0x20(%rsp,%rax,4), %ecx
               	addq	%rcx, %rbx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	%ebx, (%r14)
               	testl	%r12d, %r12d
               	jg	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	leaq	-0x1(%r12), %rsi
               	movq	%r14, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x108, %rsp            # imm = 0x108
               	retq

<once>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	addq	$0x7, %rax
               	retq

<main>:
               	subq	$0x18, %rsp
               	xorl	%esi, %esi
               	movl	%esi, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	cmpl	$0x17e0, %eax           # imm = 0x17E0
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	cmpl	$0x17e0, %eax           # imm = 0x17E0
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
