
struct_by_value_return.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<make_pair>:
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	retq

<clobber>:
               	leaq	0x121589(%rdi), %rax
               	retq

<sum_pair_pair>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movq	%rsi, %rcx
               	shrq	$0x20, %rcx
               	leaq	(%rdi,%rsi), %rdx
               	addq	%rcx, %rax
               	movl	%edx, %ecx
               	movl	%eax, %eax
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0xb, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x16, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x7, %edi
               	callq	<addr>
               	addq	$0x121589, %rax         # imm = 0x121589
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x63, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpl	$0xb, %ebx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpl	$0x16, %r12d
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0xc8, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x12c, %edi            # imm = 0x12C
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x190, %edi            # imm = 0x190
               	callq	<addr>
               	cmpl	$0x64, %ebx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpl	$0xc8, %r12d
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpl	$0x12c, %r13d           # imm = 0x12C
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpl	$0x190, %eax            # imm = 0x190
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	(%rbx,%r13), %rcx
               	addq	%r12, %rax
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
