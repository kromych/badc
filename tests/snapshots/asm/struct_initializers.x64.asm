
struct_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400251 <.text+0x31>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	subq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfe5a(%rip), %r11      # 0x4100d0
               	movslq	(%r11), %r9
               	cmpq	$0x1, %r9
               	je	0x4002ae <.text+0x8e>
               	movl	$0x1, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe1b(%rip), %r9       # 0x4100d0
               	addq	$0x8, %r9
               	movq	(%r9), %rbx
               	movl	$0x2, %r12d
               	movl	$0x3, %r14d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	cmpq	$0x5, %rax
               	je	0x40030c <.text+0xec>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfdbd(%rip), %rax      # 0x4100d0
               	addq	$0x10, %rax
               	movq	(%rax), %r15
               	movl	$0xa, %r14d
               	movl	$0x4, %ebx
               	movq	%r15, %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$0x6, %rax
               	je	0x400368 <.text+0x148>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd61(%rip), %rax      # 0x4100d0
               	addq	$0x18, %rax
               	movq	(%rax), %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4003c1 <.text+0x1a1>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd30(%rip), %rax      # 0x4100f8
               	movslq	(%rax), %rbx
               	cmpq	$0x2, %rbx
               	je	0x4003ff <.text+0x1df>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcf2(%rip), %rbx      # 0x4100f8
               	addq	$0x8, %rbx
               	movq	(%rbx), %r12
               	movl	$0x7, %r15d
               	movl	$0x8, %ebx
               	movq	%r12, %r11
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$0xf, %rax
               	je	0x40045b <.text+0x23b>
               	movl	$0x6, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc96(%rip), %rax      # 0x4100f8
               	addq	$0x18, %rax
               	movq	(%rax), %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4004b4 <.text+0x294>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc65(%rip), %rax      # 0x410120
               	movslq	(%rax), %rbx
               	cmpq	$0x3, %rbx
               	je	0x4004f2 <.text+0x2d2>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc27(%rip), %rbx      # 0x410120
               	addq	$0x8, %rbx
               	movq	(%rbx), %r14
               	movl	$0x1, %r12d
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	movq	%r12, %rsi
               	callq	*%r11
               	cmpq	$0x2, %rax
               	je	0x40054a <.text+0x32a>
               	movl	$0x9, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbcf(%rip), %rax      # 0x410120
               	addq	$0x10, %rax
               	movq	(%rax), %r15
               	movl	$0x5, %r12d
               	movl	$0x1, %ebx
               	movq	%r15, %r11
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$0x4, %rax
               	je	0x4005a6 <.text+0x386>
               	movl	$0xa, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb9b(%rip), %rax      # 0x410148
               	movslq	(%rax), %rbx
               	cmpq	$0xa, %rbx
               	je	0x4005e4 <.text+0x3c4>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb5d(%rip), %rbx      # 0x410148
               	addq	$0x4, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x14, %rax
               	je	0x400629 <.text+0x409>
               	movl	$0xc, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb20(%rip), %rax      # 0x410150
               	movslq	(%rax), %rbx
               	cmpq	$0x1, %rbx
               	je	0x400667 <.text+0x447>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfae2(%rip), %rbx      # 0x410150
               	addq	$0x4, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x2, %rax
               	je	0x4006ac <.text+0x48c>
               	movl	$0xe, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
