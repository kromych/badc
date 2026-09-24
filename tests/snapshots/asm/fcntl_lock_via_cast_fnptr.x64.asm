
fcntl_lock_via_cast_fnptr.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x42, %esi
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movw	$0x1, (%rdx)
               	movw	$0x0, 0x2(%rdx)
               	movl	$0x6, %esi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x20(%rbp), %rdx
               	movw	$0x2, (%rdx)
               	movl	$0x6, %esi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x20(%rbp), %rdx
               	movw	$0x1, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x6, %esi
               	movq	%rax, %rcx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	*%rcx
               	movq	%rax, %r14
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%r12d, %r12d
               	jne	<addr>
               	testl	%r13d, %r13d
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	testl	%r14d, %r14d
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

<__c5_sys_fcntl>:
               	jmp	<addr>
