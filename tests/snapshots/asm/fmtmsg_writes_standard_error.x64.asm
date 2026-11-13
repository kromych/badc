
fmtmsg_writes_standard_error.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x148, %rsp            # imm = 0x148
               	pushq	%rbx
               	leaq	-0x118(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x2, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x14a, %edi            # imm = 0x14A
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r8
               	leaq	<rip>, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	movl	$0x100, %edi            # imm = 0x100
               	xorl	%esi, %esi
               	movl	$0x4, %edx
               	leaq	<rip>, %rcx
               	movq	%rsi, %r8
               	movq	%rsi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %esi
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rsi
               	movl	$0xff, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x118(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x20(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x18(%rsp), %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	0x28(%rsp), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movq	0x28(%rsp), %r10
               	movb	$0x0, (%rdi,%r10)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
