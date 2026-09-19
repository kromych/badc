
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
               	movslq	%eax, %rax
               	retq

<rec>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r15
               	movq	%rsi, %r14
               	movslq	%r14d, %r14
               	xorl	%ebx, %ebx
               	cmpl	$0x40, %ebx
               	jge	<addr>
               	leaq	-0x100(%rbp), %r13
               	movslq	%ebx, %r12
               	leaq	(%r14,%r12), %rdi
               	callq	<addr>
               	movl	%eax, (%r13,%r12,4)
               	incq	%rbx
               	cmpl	$0x40, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	cmpl	$0x40, %eax
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	movslq	%eax, %rdx
               	movslq	(%rcx,%rdx,4), %rcx
               	addq	%rcx, %rbx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	%ebx, (%r15)
               	testl	%r14d, %r14d
               	jg	<addr>
               	movslq	%ebx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x1(%r14), %rsi
               	movq	%r15, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<once>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%esi, %esi
               	movl	%esi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x17e0, %rax           # imm = 0x17E0
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
