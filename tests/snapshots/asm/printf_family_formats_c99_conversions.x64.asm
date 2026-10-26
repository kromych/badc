
printf_family_formats_c99_conversions.x64:	file format elf64-x86-64

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

<v_string>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
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
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc0(%rbp), %rcx
               	movl	$0x18, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	movq	-0xc0(%rbp), %rdx
               	leaq	-0x18(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<narrow>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x18(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rax, %xmm14
               	vdivsd	%xmm0, %xmm14, %xmm1
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rcx, %xmm14
               	vdivsd	%xmm0, %xmm14, %xmm2
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rax, %xmm14
               	vdivsd	%xmm0, %xmm14, %xmm3
               	movapd	%xmm1, %xmm0
               	movapd	%xmm2, %xmm1
               	movapd	%xmm3, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0xc, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rax, %xmm14
               	vdivsd	%xmm0, %xmm14, %xmm1
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rcx, %xmm14
               	vdivsd	%xmm0, %xmm14, %xmm2
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rax, %xmm14
               	vdivsd	%xmm0, %xmm14, %xmm3
               	movapd	%xmm1, %xmm0
               	movapd	%xmm2, %xmm1
               	movapd	%xmm3, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movsd	-0x8(%rbp), %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	divsd	%xmm1, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	divsd	%xmm2, %xmm1
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x7, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movsd	-0x8(%rbp), %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	divsd	%xmm1, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	divsd	%xmm2, %xmm1
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movl	$0x12c, %ecx            # imm = 0x12C
               	movl	$0x11170, %r9d          # imm = 0x11170
               	movq	%rcx, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0xa, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movl	$0x12c, %ecx            # imm = 0x12C
               	movl	$0x11170, %r9d          # imm = 0x11170
               	movq	%rcx, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movabsq	$0x4008000000000000, %r8 # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movq	%r8, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movapd	%xmm0, %xmm2
               	movq	%rax, %xmm0
               	movq	%rax, %xmm1
               	movb	$0x3, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x1d, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movabsq	$0x4008000000000000, %r8 # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movq	%r8, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movapd	%xmm0, %xmm2
               	movq	%rax, %xmm0
               	movq	%rax, %xmm1
               	movb	$0x3, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movabsq	$0x4004000000000000, %r8 # imm = 0x4004000000000000
               	movabsq	$-0x3ffc000000000000, %r9 # imm = 0xC004000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%r8, %xmm2
               	movq	%r9, %xmm3
               	movb	$0x4, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x8, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movabsq	$0x4004000000000000, %r8 # imm = 0x4004000000000000
               	movabsq	$-0x3ffc000000000000, %r9 # imm = 0xC004000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%r8, %xmm2
               	movq	%r9, %xmm3
               	movb	$0x4, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3fb999999999999a, %rax # imm = 0x3FB999999999999A
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x16, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3fb999999999999a, %rax # imm = 0x3FB999999999999A
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x1a56e1fc2f8f359, %rcx # imm = 0x1A56E1FC2F8F359
               	movabsq	$0x3ee4f8b588e368f1, %r8 # imm = 0x3EE4F8B588E368F1
               	movabsq	$0x54b249ad2594c37d, %r9 # imm = 0x54B249AD2594C37D
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%r8, %xmm2
               	movq	%r9, %xmm3
               	movb	$0x4, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x27, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x1a56e1fc2f8f359, %rcx # imm = 0x1A56E1FC2F8F359
               	movabsq	$0x3ee4f8b588e368f1, %r8 # imm = 0x3EE4F8B588E368F1
               	movabsq	$0x54b249ad2594c37d, %r9 # imm = 0x54B249AD2594C37D
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%r8, %xmm2
               	movq	%r9, %xmm3
               	movb	$0x4, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movl	$0x5, %ecx
               	movq	$-0x6, %r8
               	movl	$0x7, %r9d
               	movq	$-0x1, %rax
               	movl	$0xff, %ebx
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movq	%rax, %rbx
               	cmpl	$0xc, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movl	$0x5, %ecx
               	movq	$-0x6, %r8
               	movl	$0x7, %r9d
               	movq	$-0x1, %rax
               	movl	$0xff, %r12d
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x400921f9f01b866e, %rax # imm = 0x400921F9F01B866E
               	movabsq	$0x4004000000000000, %r9 # imm = 0x4004000000000000
               	movl	$0x5, %ecx
               	movl	$0x6, %r8d
               	movq	%rax, %xmm0
               	movq	%r9, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x14, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x400921f9f01b866e, %rax # imm = 0x400921F9F01B866E
               	movabsq	$0x4004000000000000, %r9 # imm = 0x4004000000000000
               	movl	$0x5, %ecx
               	movl	$0x6, %r8d
               	movq	%rax, %xmm0
               	movq	%r9, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movl	$0xff, %ecx
               	movl	$0x8, %r8d
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movabsq	$0x3ff0000000000000, %r9 # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	movq	%r9, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x13, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movl	$0xff, %ecx
               	movl	$0x8, %r8d
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movabsq	$0x3ff0000000000000, %r9 # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	movq	%r9, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movl	$0x71, %r8d
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x9, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movl	$0x71, %r8d
               	leaq	<rip>, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$-0x4008000000000000, %rax # imm = 0xBFF8000000000000
               	movl	$0x2a, %ecx
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x12, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$-0x4008000000000000, %rax # imm = 0xBFF8000000000000
               	movl	$0x2a, %ecx
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x44b52d02c7e14af6, %rax # imm = 0x44B52D02C7E14AF6
               	movabsq	$0x412e848000000000, %rcx # imm = 0x412E848000000000
               	movabsq	$0x3fb999999999999a, %r8 # imm = 0x3FB999999999999A
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%r8, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x31, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x44b52d02c7e14af6, %rax # imm = 0x44B52D02C7E14AF6
               	movabsq	$0x412e848000000000, %rcx # imm = 0x412E848000000000
               	movabsq	$0x3fb999999999999a, %r8 # imm = 0x3FB999999999999A
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%r8, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x64, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rdx
               	movl	$0x3039, %ecx           # imm = 0x3039
               	movq	%rdi, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movl	$0x61, %edx
               	xorl	%ecx, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	cmpb	$0x0, 0x1(%rax)
               	je	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rsi
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
               	movl	$0x201, %edx            # imm = 0x201
               	movq	%rax, %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<wide>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	pushq	%r12
               	pushq	%rbx
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x108(%rbp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r8
               	movl	$0x63, %r9d
               	movl	$0x77, %eax
               	movl	$0x12c, %ebx            # imm = 0x12C
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movsd	-0x8(%rbp), %xmm0
               	movq	%r12, %xmm14
               	vdivsd	%xmm0, %xmm14, %xmm1
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movapd	%xmm1, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x12, %rax
               	jne	<addr>
               	leaq	-0x108(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x118(%rbp), %rdi
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movl	$0x33, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	movl	$0x7, %ecx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x108(%rbp), %rdi
               	movl	$0x40, %esi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x108(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<comma>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1, %edi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	<rip>, %rax # <addr>
               	movq	0x10(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%ebx, %ebx
               	movl	$0x1, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xa0, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x3fd0000000000000, %rcx # imm = 0x3FD0000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3c, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
