
binary_operator_order.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, (%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movl	(%rax), %ecx
               	leaq	-0x1(%rcx), %rdx
               	movl	%edx, (%rax)
               	subq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx      # <addr>
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	$0x1, (%rdx,%rcx,4)
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	$0x2, (%rdx,%rcx,4)
               	leaq	<rip>, %rcx      # <addr>
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rcx)
               	movl	$0x3, (%rdx,%rax,4)
               	movl	(%rcx), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movl	0x8(%rax), %edx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	xorl	%edx, %edx
               	movl	%edx, (%rcx)
               	movslq	%edx, %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rcx)
               	movl	%edx, (%rax,%rsi,4)
               	leaq	<rip>, %rcx      # <addr>
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rcx)
               	movl	%edx, (%rax,%rsi,4)
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rcx)
               	movl	$0x4, (%rax,%rdx,4)
               	movl	(%rcx), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	0x8(%rcx), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	xorl	%edx, %edx
               	movl	%edx, (%rax)
               	movslq	%edx, %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	$0x1, (%rcx,%rsi,4)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rcx,%rsi,4)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1c, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx      # <addr>
               	movslq	%ecx, %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	%ecx, (%rdx,%rsi,4)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	%ecx, (%rdx,%rsi,4)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1d, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx      # <addr>
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	$0x6, (%rdx,%rcx,4)
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	$0x1, (%rdx,%rcx,4)
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	$0x6, (%rcx,%rdx,4)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	$0x3, (%rcx,%rsi,4)
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	$0x6, (%rcx,%rsi,4)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	$0x3, (%rcx,%rsi,4)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	$0x6, (%rdx,%rsi,4)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	$0x6, (%rdx,%rsi,4)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx      # <addr>
               	movslq	%ecx, %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	%ecx, (%rdx,%rsi,4)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	%ecx, (%rdx,%rsi,4)
               	leaq	<rip>, %rdx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	$0x1, (%rdx,%rsi,4)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, (%rax)
               	movl	$0x1, (%rdx,%rsi,4)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	xorl	%eax, %eax
               	retq
