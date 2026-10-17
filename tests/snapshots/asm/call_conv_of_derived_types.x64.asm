
call_conv_of_derived_types.x64:	file format elf64-x86-64

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

<msf>:
               	leaq	(%rcx,%rcx,4), %rax
               	addq	%rdx, %rax
               	retq

<svf>:
               	leaq	(%rdi,%rdi,2), %rax
               	subq	%rsi, %rax
               	retq

<get_svf>:
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	retq

<via_typeof>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %r13
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0xf4240, %rax, %r14    # imm = 0xF4240
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	imulq	$0x2710, %rax, %rax     # imm = 0x2710
               	leaq	(%r14,%rax), %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<via_auto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %r13
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r14
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	addq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<via_old_style>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r13
               	movq	%rcx, %r12
               	movq	%rdx, %rbx
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rdi
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r14
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r13
               	addq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<via_va_arg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd8, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	pushq	%rbx
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movq	(%rax), %rax
               	movl	$0x4, %ecx
               	movl	$0x3, %edx
               	subq	$0x20, %rsp
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %rbx
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movq	(%rax), %rax
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	*%rax
               	addq	%rbx, %rax
               	leaq	-0x18(%rbp), %rcx
               	movslq	-0xd0(%rbp), %rcx
               	addq	%rcx, %rax
               	subq	$0x2, %rax
               	popq	%rbx
               	leave
               	retq

<via_cast>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	imulq	$0x64, %rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<via_expression_forms>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movslq	%edx, %rdx
               	movq	%rsi, %r12
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r13, %rax
               	imulq	$0x64, %rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	addq	%r13, %rax
               	imulq	$0x64, %rax, %r13
               	callq	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r13, %rax
               	imulq	$0x64, %rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	addq	%r13, %rax
               	imulq	$0x64, %rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	jmp	<addr>

<via_objects>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movslq	%edx, %rdx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax,%rdx,8), %rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	imulq	$0x2710, %rax, %r13     # imm = 0x2710
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	0x8(%rax), %rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	addq	%rax, %r13
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	addq	%r13, %rax
               	subq	$0x17, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x16056eb, %rax        # imm = 0x16056EB
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %ecx
               	movl	$0x3, %edx
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %rbx
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	addq	%rbx, %rax
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x39b, %rax            # imm = 0x39B
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movabsq	$0x35c416c155, %r11     # imm = 0x35C416C155
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x16895, %rax          # imm = 0x16895
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
