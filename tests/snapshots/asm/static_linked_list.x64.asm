
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
               	addq	$0x8, %r11
               	leaq	0xfe80(%rip), %r8       # 0x4100f0
               	movq	%r8, (%r11)
               	movl	$0x2, %r9d
               	movl	%r9d, (%r8)
               	addq	$0x8, %r8
               	leaq	0xfe76(%rip), %r11      # 0x410100
               	movq	%r11, (%r8)
               	movl	$0x3, %r9d
               	movl	%r9d, (%r11)
               	addq	$0x8, %r11
               	xorq	%r8, %r8
               	movq	%r8, (%r11)
               	movl	%r8d, -0x8(%rbp)
               	leaq	0xfe62(%rip), %r9       # 0x410110
               	movq	(%r9), %r8
               	movq	%r8, -0x10(%rbp)
               	jmp	0x4002ba <.text+0x8a>
               	movq	-0x10(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x4002f3 <.text+0xc3>
               	movslq	-0x8(%rbp), %r9
               	movq	-0x10(%rbp), %r8
               	movslq	(%r8), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x8(%rbp)
               	addq	$0x8, %r8
               	movq	(%r8), %r11
               	movq	%r11, -0x10(%rbp)
               	jmp	0x4002ba <.text+0x8a>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0x6, %r11
               	je	0x400312 <.text+0xe2>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
