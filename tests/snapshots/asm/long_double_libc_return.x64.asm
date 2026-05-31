
long_double_libc_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002d7 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	0xfe09(%rip), %rbx      # 0x410100
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4005e7 <strtold>
               	subq	$0x10, %rsp
               	fstpl	(%rsp)
               	movq	(%rsp), %r8
               	addq	$0x10, %rsp
               	movabsq	$0x45f0000000000000, %r12 # imm = 0x45F0000000000000
               	movq	%r8, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400378 <.text+0xb8>
               	movl	$0xb, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfda1(%rip), %r14      # 0x410120
               	xorq	%rbx, %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x4005e7 <strtold>
               	subq	$0x10, %rsp
               	fstpl	(%rsp)
               	movq	(%rsp), %r8
               	addq	$0x10, %rsp
               	movabsq	$0x43f0000000000000, %rbx # imm = 0x43F0000000000000
               	movq	%r8, %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x4003ff <.text+0x13f>
               	movl	$0xc, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movl	$0x35, %r14d
               	movq	%r12, %xmm0
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x4005ed <ldexp>
               	movq	%xmm0, %r8
               	movabsq	$0x4340000000000000, %r14 # imm = 0x4340000000000000
               	movq	%r8, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x40047f <.text+0x1bf>
               	movl	$0xd, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
