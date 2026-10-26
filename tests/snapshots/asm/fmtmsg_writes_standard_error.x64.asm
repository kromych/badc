
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

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax # <addr>
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movq	0x10(%rax), %rax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rax), %rax
               	movq	%rax, 0x10(%rcx)
               	leaq	<rip>, %rax # <addr>
               	movq	0x10(%rax), %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
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
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
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
               	movq	%rax, %r13
               	movl	$0x100, %edi            # imm = 0x100
               	xorl	%esi, %esi
               	movl	$0x4, %edx
               	leaq	<rip>, %rcx
               	movq	%rsi, %r8
               	movq	%rsi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %esi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rsi
               	movl	$0xff, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x118(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%r13d, %r13d
               	jne	<addr>
               	testl	%r14d, %r14d
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	testq	%r12, %r12
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movb	$0x0, (%rdi,%r12)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
