
libc_pread64_pwrite64.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x38(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0x10, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movb	%cl, -0x28(%rbp)
               	movb	%cl, -0x27(%rbp)
               	movb	%cl, -0x26(%rbp)
               	movb	%cl, -0x25(%rbp)
               	movb	%cl, -0x24(%rbp)
               	movb	%cl, -0x23(%rbp)
               	movb	%cl, -0x22(%rbp)
               	movb	%cl, -0x21(%rbp)
               	movb	%cl, -0x20(%rbp)
               	movb	%cl, -0x1f(%rbp)
               	movb	%cl, -0x1e(%rbp)
               	movb	%cl, -0x1d(%rbp)
               	movb	%cl, -0x1c(%rbp)
               	movb	%cl, -0x1b(%rbp)
               	movb	%cl, -0x1a(%rbp)
               	movb	%cl, -0x19(%rbp)
               	movl	$0x10, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r12 # <addr>
               	leaq	-0x38(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x10, %ecx
               	movq	%rbx, %rdi
               	callq	*%rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movb	$0x0, -0x28(%rbp)
               	movb	$0x0, -0x27(%rbp)
               	movb	$0x0, -0x26(%rbp)
               	movb	$0x0, -0x25(%rbp)
               	movb	$0x0, -0x24(%rbp)
               	movb	$0x0, -0x23(%rbp)
               	movb	$0x0, -0x22(%rbp)
               	movb	$0x0, -0x21(%rbp)
               	movb	$0x0, -0x20(%rbp)
               	movb	$0x0, -0x1f(%rbp)
               	movb	$0x0, -0x1e(%rbp)
               	movb	$0x0, -0x1d(%rbp)
               	movb	$0x0, -0x1c(%rbp)
               	movb	$0x0, -0x1b(%rbp)
               	movb	$0x0, -0x1a(%rbp)
               	movb	$0x0, -0x19(%rbp)
               	movl	$0x8, %edx
               	movl	$0x10, %ecx
               	movq	%rbx, %rdi
               	callq	*%r12
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
