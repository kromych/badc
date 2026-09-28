
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
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rsi,%rax)
               	jne	<addr>
               	movq	(%rdi), %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movq	(%rdi), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	incq	%rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rdx,%rax)
               	jne	<addr>
               	movq	0x10(%rdi), %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	movq	0x10(%rdi), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
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
               	testl	%eax, %eax
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
               	testl	%eax, %eax
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
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
