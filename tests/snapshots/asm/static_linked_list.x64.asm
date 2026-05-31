
static_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	0xfe87(%rip), %r11      # 0x4100e0
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	leaq	0xfe7d(%rip), %r11      # 0x4100f0
               	movq	%r11, (%r8)
               	movl	$0x2, %r9d
               	movl	%r9d, (%r11)
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	leaq	0xfe70(%rip), %r11      # 0x410100
               	movq	%r11, (%r8)
               	movl	$0x3, %r9d
               	movl	%r9d, (%r11)
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	xorq	%r11, %r11
               	movq	%r11, (%r8)
               	movl	%r11d, -0x8(%rbp)
               	leaq	0xfe59(%rip), %r9       # 0x410110
               	movq	(%r9), %r11
               	movq	%r11, -0x10(%rbp)
               	jmp	0x4002c3 <.text+0x93>
               	movq	-0x10(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400301 <.text+0xd1>
               	movslq	-0x8(%rbp), %r11
               	movq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x8(%rbp)
               	movq	%r9, %r8
               	addq	$0x8, %r8
               	movq	(%r8), %r9
               	movq	%r9, -0x10(%rbp)
               	jmp	0x4002c3 <.text+0x93>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x6, %r9
               	je	0x400320 <.text+0xf0>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
