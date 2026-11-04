
tokenizers_keep_state_in_the_caller.x64:	file format elf64-x86-64

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

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbp
               	retq

<wide>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x28(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rdi)
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movl	0x18(%rcx), %r10d
               	movl	%r10d, 0x18(%rax)
               	movq	$0x0, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	leaq	<rip>, %rsi
               	leaq	-0x70(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpq	$0x0, -0x70(%rbp)
               	jne	<addr>
               	movl	$0x1d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x48(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpq	$0x0, -0x68(%rbp)
               	jne	<addr>
               	movl	$0x1e, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x70(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x20, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x70(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x22, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x70(%rbp), %rdx
               	callq	*%rbx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	callq	*%rbx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	$0x0, -0x60(%rbp)
               	leaq	<rip>, %rsi
               	leaq	-0x60(%rbp), %rdx
               	callq	*%rbx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x27, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<narrow>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movzwq	0x8(%rax), %r10
               	movw	%r10w, 0x8(%rdi)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	movzbq	0x6(%rcx), %r10
               	movb	%r10b, 0x6(%rax)
               	movq	$0x0, -0x20(%rbp)
               	movq	$0x0, -0x18(%rbp)
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x20(%rbp)
               	jne	<addr>
               	movl	$0x30, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x18(%rbp)
               	jne	<addr>
               	movl	$0x31, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x33, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	*%rbx
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	callq	*%rbx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x36, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	*%rbx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x37, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<call_wcstok>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<call_strtok_r>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
