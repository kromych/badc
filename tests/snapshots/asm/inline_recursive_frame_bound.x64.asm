
inline_recursive_frame_bound.x64:	file format elf64-x86-64

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

<scale>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	retq

<rec>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r14
               	movslq	%esi, %r12
               	xorl	%ebx, %ebx
               	leaq	-0x100(%rbp), %r13
               	leaq	(%r12,%rbx), %rdi
               	callq	<addr>
               	movl	%eax, (%r13,%rbx,4)
               	incq	%rbx
               	cmpl	$0x40, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	leaq	-0x100(%rbp), %rcx
               	movslq	(%rcx,%rax,4), %rcx
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
               	leave
               	retq
               	leaq	-0x1(%r12), %rsi
               	movq	%r14, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<once>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	addq	$0x7, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%esi, %esi
               	movl	%esi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpl	$0x17e0, %eax           # imm = 0x17E0
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x17e0, %eax           # imm = 0x17E0
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
