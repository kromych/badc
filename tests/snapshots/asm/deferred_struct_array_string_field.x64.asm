
deferred_struct_array_string_field.x64:	file format elf64-x86-64

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

<check>:
               	movq	(%rdi), %rax
               	movsbq	(%rax), %rax
               	movsbq	(%rsi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x10(%rdi), %rax
               	movsbq	(%rax), %rax
               	movsbq	(%rdx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%ecx, %ecx
               	movslq	%ecx, %rax
               	cmpb	$0x0, (%rsi,%rax)
               	jne	<addr>
               	movq	(%rdi), %r8
               	cmpb	$0x0, (%r8,%rax)
               	je	<addr>
               	movq	(%rdi), %r8
               	movsbq	(%r8,%rax), %r8
               	movsbq	(%rsi,%rax), %rax
               	cmpl	%eax, %r8d
               	jne	<addr>
               	incq	%rcx
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%ecx, %ecx
               	movslq	%ecx, %rax
               	cmpb	$0x0, (%rdx,%rax)
               	jne	<addr>
               	movq	0x10(%rdi), %rsi
               	cmpb	$0x0, (%rsi,%rax)
               	je	<addr>
               	movq	0x10(%rdi), %rsi
               	movsbq	(%rsi,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	jne	<addr>
               	incq	%rcx
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x18(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
