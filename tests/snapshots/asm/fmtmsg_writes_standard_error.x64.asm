
fmtmsg_writes_standard_error.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x138, %rsp            # imm = 0x138
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x28(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	callq	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	movl	$0x14a, %edi            # imm = 0x14A
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r8
               	leaq	<rip>, %r9
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movl	$0x100, %edi            # imm = 0x100
               	xorl	%esi, %esi
               	movl	$0x4, %edx
               	leaq	<rip>, %rcx
               	xorl	%r8d, %r8d
               	xorl	%r9d, %r9d
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	callq	<addr>
               	movq	%r12, %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	leaq	0x40(%rsp), %rsi
               	movl	$0xff, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	cmpl	$0x0, 0x18(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rsp)
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	testq	%r12, %r12
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	leaq	0x40(%rsp), %rdi
               	movb	$0x0, 0x40(%rsp,%r12)
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
