
one_shape_at_two_widths_is_two_values.x64:	file format elf64-x86-64

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

<compare_twice>:
               	cmpl	%esi, %edi
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rsi, %rdi
               	setl	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	retq

<compare_in_a_loop>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8 # <addr>
               	cmpl	%edx, %eax
               	jge	<addr>
               	cmpq	%rsi, %rdi
               	setl	%r9b
               	movzbq	%r9b, %r9
               	movl	%r9d, (%r8,%rax,4)
               	cmpl	%esi, %edi
               	setl	%r9b
               	movzbq	%r9b, %r9
               	movl	%r9d, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	retq

<convert_narrow_first>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdi, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdi, %xmm1
               	cmpl	%esi, %eax
               	jge	<addr>
               	movss	%xmm0, (%rdx,%rax,4)
               	movsd	%xmm1, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	retq

<convert_wide_first>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdi, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdi, %xmm1
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsd	%xmm0, (%rcx,%rax,8)
               	movss	%xmm1, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	retq

<compare_per_element>:
               	cmpl	$0x5, %edi
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x5, %rdi
               	setl	%cl
               	movzbq	%cl, %rcx
               	movl	%eax, (%rsi)
               	movl	%ecx, 0x4(%rsi)
               	movl	%eax, 0x8(%rsi)
               	movl	%ecx, 0xc(%rsi)
               	retq

<main>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1, %esi
               	movq	<rip>, %rax # <addr>
               	shlxq	%rax, %rsi, %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movl	$0x1, %ebx
               	xorl	%ecx, %ecx
               	cmpl	$0x1, %eax
               	cmoveq	%rcx, %rbx
               	movq	%r12, %rdi
               	movl	$0x1, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	orq	$0x2, %rbx
               	movq	%r12, %rax
               	sarq	$0x8, %rax
               	leaq	0x1(%rax), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x4, %rbx
               	movq	%r12, %rax
               	shlq	$0x1c, %rax
               	movq	%r12, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	leaq	0x1(%rax), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	movq	%rbx, %rax
               	orq	$0x8, %rax
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	<rip>, %xmm0
               	cmovneq	%rax, %rbx
               	cmovpq	%rax, %rbx
               	movq	%r12, %rdi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movl	0x10(%rsp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x0, 0x14(%rsp)
               	jne	<addr>
               	movl	0x18(%rsp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x0, 0x1c(%rsp)
               	je	<addr>
               	orq	$0x10, %rbx
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
