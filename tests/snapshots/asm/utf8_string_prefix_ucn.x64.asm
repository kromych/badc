
utf8_string_prefix_ucn.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x2, %eax
               	jae	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	andq	$0xff, %rsi
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jae	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	andq	$0xff, %rsi
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x3, %eax
               	jae	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	andq	$0xff, %rsi
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jb	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x5, %eax
               	jae	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	andq	$0xff, %rsi
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jb	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x5, %eax
               	jae	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	andq	$0xff, %rsi
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jb	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x5, %eax
               	jae	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	andq	$0xff, %rsi
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jb	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jae	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	andq	$0xff, %rsi
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x2, %eax
               	jae	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	andq	$0xff, %rsi
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jae	<addr>
               	movsbq	(%rcx,%rax), %rsi
               	andq	$0xff, %rsi
               	movsbq	(%rdx,%rax), %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x18, %eax
               	retq
               	movl	$0x16, %eax
               	retq
               	movl	$0x14, %eax
               	retq
               	movl	$0xd, %eax
               	retq
               	movl	$0xc, %eax
               	retq
               	movl	$0xb, %eax
               	retq
               	movl	$0x9, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	movl	$0x5, %eax
               	retq
