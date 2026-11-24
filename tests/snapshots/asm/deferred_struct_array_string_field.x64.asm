
deferred_struct_array_string_field.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	(%rsp), %rdi
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
               	leaq	0x20(%rsp), %rdi
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
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x5, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x4, %eax
               	addq	$0x48, %rsp
               	retq
