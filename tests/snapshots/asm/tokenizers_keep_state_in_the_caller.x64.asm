
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

<wide>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rdi, 0x8(%rsp)
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
               	movq	0x8(%rsp), %r11
               	callq	*%r11
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x70(%rbp)
               	jne	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	leaq	-0x48(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	movq	0x8(%rsp), %r11
               	callq	*%r11
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x68(%rbp)
               	jne	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x70(%rbp), %rdx
               	movq	0x8(%rsp), %r11
               	callq	*%r11
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	movq	0x8(%rsp), %r11
               	callq	*%r11
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x70(%rbp), %rdx
               	movq	0x8(%rsp), %r11
               	callq	*%r11
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	movq	0x8(%rsp), %r11
               	callq	*%r11
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x70(%rbp), %rdx
               	movq	0x8(%rsp), %r11
               	callq	*%r11
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	movq	0x8(%rsp), %r11
               	callq	*%r11
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	$0x0, -0x60(%rbp)
               	leaq	<rip>, %rsi
               	leaq	-0x60(%rbp), %rdx
               	movq	0x8(%rsp), %r11
               	callq	*%r11
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x27, %eax
               	leave
               	retq
               	xorl	%eax, %eax
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
               	subq	$0x30, %rsp
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
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
               	callq	<addr>
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
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	<addr>
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
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x33, %eax
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x34, %eax
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x36, %eax
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x37, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
