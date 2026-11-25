
libc_pread64_pwrite64.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	pushq	%rbx
               	leaq	0x48(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
               	leaq	0x28(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%rbx, %rdi
               	movl	$0x10, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
               	movq	$0x0, 0x38(%rsp)
               	movq	$0x0, 0x40(%rsp)
               	movq	%rbx, %rdi
               	leaq	0x38(%rsp), %rsi
               	movl	$0x10, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
               	leaq	0x28(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, %rdi
               	leaq	0x28(%rsp), %rsi
               	movl	$0x8, %edx
               	movl	$0x10, %ecx
               	callq	*%rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
               	movq	$0x0, 0x38(%rsp)
               	movq	$0x0, 0x40(%rsp)
               	movq	0x18(%rsp), %r11
               	movq	%rbx, %rdi
               	leaq	0x38(%rsp), %rsi
               	movl	$0x8, %edx
               	movl	$0x10, %ecx
               	callq	*%r11
               	cmpq	$0x8, %rax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
               	leaq	0x28(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x60, %rsp
               	retq
